class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :mirrors

  enum status: { past: "past", upcoming: "upcoming" }
end
