class ChatroomsController < ApplicationController
  before_action :find_chatroom, only: [:show]
  before_action :find_chatroom_messages, only: [:show]
  before_action :mark_messages_as_read, only: [:show]
  before_action :check_participating!, only: [:show]

  def show
    @message = Message.new
    @chatrooms = Chatroom.participating(current_user).order('updated_at DESC')
  end

  def index
    # index all chatrooms by updated_at descending order
    @chatrooms = policy_scope(Chatroom)
    @message = Message.new
    return if @chatrooms.empty?
    # last updated chatroom should be displayed by default
    @chatroom = @chatrooms.first
    find_chatroom_messages
    # all unread messages should change status to 'read' in last updated chatroom
    mark_messages_as_read
  end

  private

  def find_chatroom_messages
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
