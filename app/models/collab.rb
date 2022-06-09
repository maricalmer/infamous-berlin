class Collab < ApplicationRecord
  belongs_to :project
  belongs_to :member, class_name: 'User', foreign_key: :user_id

  validates :member, uniqueness: { scope: :project, message: "you cannot become a member of your own project" }
end
