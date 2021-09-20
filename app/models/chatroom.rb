class Chatroom < ApplicationRecord
  self.implicit_order_column = "updated_at"
  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  # has_many :users, through: :messages
  # belongs_to :user
  # belongs_to :project

  validates :author, uniqueness: { scope: :receiver }

  scope :participating, -> (user) do
    where("(chatrooms.author_id = ? OR chatrooms.receiver_id = ?)", user.id, user.id)
  end

  def with(current_user)
    # self.user == current_user ? self.project.user : self.user
    # self.messages.first.user == current_user ? self.messages.first.receiver : self.messages.first.user
    current_user == author ? receiver : author
  end

  def participates?(user)
    # self.user == user || self.project.user == user
    # self.messages.first.user == user || self.messages.first.receiver == user
    author == user || receiver == user
  end
end
