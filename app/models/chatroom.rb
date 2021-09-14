class Chatroom < ApplicationRecord
  self.implicit_order_column = "created_at"
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  # belongs_to :user
  # belongs_to :project

  validates :users, uniqueness: true

  def with(current_user)
    # self.user == current_user ? self.project.user : self.user
    self.messages.first.user == current_user ? self.messages.first.receiver : self.messages.first.user
  end

  def participates?(user)
    # self.user == user || self.project.user == user
    self.messages.first.user == user || self.messages.first.receiver == user
  end
end
