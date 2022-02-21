class Collab < ApplicationRecord
  belongs_to :project
  belongs_to :member, class_name: 'User', foreign_key: :user_id
end
