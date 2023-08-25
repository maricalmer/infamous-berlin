class ChatroomsController < ApplicationController
  before_action :find_chatroom, only: [:show]
  before_action :fetch_chatroom_messages, only: [:show]
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
    fetch_chatroom_messages
    mark_messages_as_read
  end

  private

  def fetch_chatroom_messages
    @messages = Workflows::ChatroomContext.new(@chatroom).set_messages
  end

  def mark_messages_as_read
    Workflows::ChatroomContext.new.mark_messages_as_read(@messages, current_user)
  end

  def check_participating!
    redirect_to root_path unless @chatroom&.participates?(current_user)
  end

  def find_chatroom
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
  end
end
