class MessagesController < ApplicationController
  before_action :find_or_create_chatroom, only: [:create]
  before_action :find_user, only: [:create]

  def create
    @message = Message.new(message_params)
    authorize @message
    @message.chatroom = @chatroom
    @message.user = current_user
    @message.anchor_id = @chatroom.messages.count + 1
    if @message.save
      # broadcast new message to channel subscriber via Action Cable
      ChatroomChannel.broadcast_to(@chatroom, render_to_string(partial: "message", locals: { message: @message }))
      if @chatroom.messages.size < 2
        redirect_to user_path(@user)
      else
        redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.anchor_id}")
      end
    else
      @chatroom.destroy
      respond_to do |format|
        format.js { render :new }
      end
    end
  end

  private

  def find_or_create_chatroom
    if params[:receiver_id]
      receiver = User.find(params[:receiver_id])
      @chatroom = Chatroom.find_by(author: current_user, receiver: receiver)
      @chatroom = Chatroom.find_by(author: receiver, receiver: current_user) if @chatroom.nil?
      @chatroom = Chatroom.create(author: current_user, receiver: receiver) if @chatroom.nil?
    else
      @chatroom = Chatroom.find(params[:chatroom_id])
    end
  end

  def find_user
    if params[:receiver_id]
      @user = User.find(params[:receiver_id])
    else
      @user = User.find(@chatroom.receiver_id)
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
