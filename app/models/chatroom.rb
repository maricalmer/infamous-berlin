class Chatroom < ApplicationRecord
  self.implicit_order_column = "created_at"
  belongs_to :user
  belongs_to :project
  has_many :messages, dependent: :destroy

  validates :user, uniqueness: { scope: :project }

  def with(current_user)
    self.user == current_user ? self.project.user : self.user
  end

  def participates?(user)
    self.user == user || self.project.user == user
  end
end
