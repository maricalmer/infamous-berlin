class Chatroom < ApplicationRecord
  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  self.implicit_order_column = "updated_at"
  validate :author_receiver_pair_must_be_unique

  scope :participating, lambda { |user|
    where("(chatrooms.author_id = ? OR chatrooms.receiver_id = ?)", user.id, user.id)
  }

  # require "workflows/chatroom_context"

  def with(current_user)
    Workflows::ChatroomContext.new(self).find_other_participant(current_user)
  end

  def participates?(user)
    Workflows::ChatroomContext.new(self).participates?(user)
  end

  private

  def author_receiver_pair_must_be_unique
    Workflows::ChatroomContext.new(self).author_receiver_pair_must_be_unique
  end
end
