class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]
  before_action :set_messages, only: [:show]
  before_action :mark_messages_as_read, only: [:show]
  before_action :check_participating!, only: [:show]

  def create
    @chatroom = Chatroom.new
    authorize @chatroom
    @message = Message.new
    if @chatroom.save!
      redirect_to user_path(@user)
    else
      render "user/show"
    end
  end

  def show
    @message = Message.new
    @chatrooms = Chatroom.participating(current_user).order('updated_at DESC')
  end

  def index
    # @chatrooms = Chatroom.participating(current_user).order('updated_at DESC')
    @chatrooms = policy_scope(Chatroom)
    @message = Message.new
    unless @chatrooms.empty?
      @chatroom = @chatrooms.first
      set_messages
      mark_messages_as_read
    end
  end

  private

  def set_messages
    @messages = Message.includes(:chatroom, :user)
                       .where("chatroom_id = ?", @chatroom.id)
                       .order('messages.created_at ASC')
                       .references(:chatroom)
  end

  def mark_messages_as_read
    @messages.where.not(user_id: current_user).where(read_by_receiver: false).each do |message|
      message.read_by_receiver = true
      message.save
    end
  end

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
  end

  def check_participating!
    redirect_to root_path unless @chatroom && @chatroom.participates?(current_user)
  end
end
