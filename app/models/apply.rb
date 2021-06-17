class Apply < ApplicationRecord
  belongs_to :applicant, foreign_key: 'applicant_id', class_name: 'User'
  belongs_to :applying, foreign_key: 'applying_id', class_name: 'Project'

  enum status: { on_hold: "on_hold", accepted: "accepted", rejected: "rejected" }

  def find_project
    Project.find(applying_id)
  end

end
