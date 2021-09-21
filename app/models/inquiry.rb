class Inquiry < ApplicationRecord
  # belongs_to :applicant, foreign_key: 'applicant_id', class_name: 'User'
  # belongs_to :applying, foreign_key: 'applying_id', class_name: 'Project'
  belongs_to :user
  belongs_to :job

  validates :text, presence: true, length: { minimum: 10, too_short: "%{count} characters minimum" }
  # validates :user, uniqueness: { scope: :job, message: "you have already applied to this offer" }

  enum status: { on_hold: "on_hold", accepted: "accepted", rejected: "rejected" }

  # def find_project
  #   Project.find(applying_id)
  # end

end
