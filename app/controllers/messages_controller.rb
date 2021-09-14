class MessagesController < ApplicationController
  before_action :find_chatroom, only: [:create]
  before_action :find_project, only: [:create]

  def create
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    @message.receiver_id = @project.user == current_user ? @chatroom.user.id : @project.user.id
    @message.anchor_id = @chatroom.messages.count + 1
    if @message.save
      ChatroomChannel.broadcast_to(@chatroom, render_to_string(partial: "message", locals: { message: @message }))
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.anchor_id}")
    else
      @chatroom.destroy
      respond_to do |format|
        format.js { render :new }
      end
    end
  end

  private

  def find_chatroom
    if params[:project_id]
      @chatroom = Chatroom.find_or_create_by(user: current_user, project: Project.find(params[:project_id]))
    else
      @chatroom = Chatroom.find(params[:chatroom_id])
    end
  end

  def find_project
    if params[:chatroom_id]
      @project = @chatroom.project
    else
      @project = Project.find(params[:project_id])
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

# ^^ find new solution without project_id
