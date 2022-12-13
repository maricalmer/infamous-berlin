class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]
  before_action :set_messages, only: [:show]
  before_action :mark_messages_as_read, only: [:show]
  before_action :check_participating!, only: [:show]

  def show
    @message = Message.new
    @chatrooms = Chatroom.participating(current_user).order('updated_at DESC')
  end

  def index
    @chatrooms = policy_scope(Chatroom)
    @message = Message.new
    return if @chatrooms.empty?

    @chatroom = @chatrooms.first
    set_messages
    mark_messages_as_read
  end

  private

  def set_messages
    @messages = Workflows::ChatroomContext.new(@chatroom).set_messages
  end

  def mark_messages_as_read
    Workflows::ChatroomContext.new.mark_messages_as_read(@messages, current_user)
  end

  def check_participating!
    redirect_to root_path unless @chatroom&.participates?(current_user)
    # redirect_to root_path unless @chatroom && @chatroom.participates?(current_user)
  end

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
  end
end
