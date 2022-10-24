class ChatroomContext
  attr_reader :chatroom

  def initialize(chatroom)
    @chatroom = chatroom
  end

  def find_other_participant(user)
    if user == @chatroom.author
      @chatroom.receiver
    elsif user == @chatroom.receiver
      @chatroom.author
    end
  end

  def participates?(user)
    @chatroom.author == user || @chatroom.receiver == user
  end

  def author_receiver_pair_must_be_unique
    return unless Chatroom.where(author_id: [@chatroom.author_id, @chatroom.receiver_id],
                                 receiver_id: [@chatroom.author_id, @chatroom.receiver_id])
                          .where.not(id: @chatroom.id)
                          .present?

    @chatroom.errors.add(:author_id, "conversation already exists")
  end

  def set_messages
    Message.includes(:chatroom, :user)
           .where("chatroom_id = ?", @chatroom.id)
           .order('messages.created_at ASC')
           .references(:chatroom)
  end

  def mark_messages_as_read(messages, user)
    messages.where.not(user_id: user).where(read_by_receiver: false).each do |message|
      message.read_by_receiver = true
      message.save
    end
  end
end
