class Message < ApplicationRecord
  belongs_to :chatroom, touch: true
  belongs_to :user

  validates :content, presence: true
end
