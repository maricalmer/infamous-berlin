class Inquiry < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :motivation, presence: true,
                         length: { minimum: 10, too_short: "%{count} characters minimum" },
                         format: { without: /(<|>|&)/, message: "cannot include <, >, and &" }
  validates :experience, presence: true,
                         length: { minimum: 10, too_short: "%{count} characters minimum" },
                         format: { without: /(<|>|&)/, message: "cannot include <, >, and &" }
  validates :user, uniqueness: { scope: :job, message: "you have already applied to this offer" }

  enum status: { on_hold: "on_hold", accepted: "accepted", rejected: "rejected" }
  has_one_attached :attached_file

  def update_collabs(inquiry_status)
    case inquiry_status
    when "accepted"
      Collab.create(project_id: job.project.id, user_id: user.id)
    when "rejected"
      collab = Collab.where(project_id: job.project.id).where(user_id: user.id)
      collab.first.destroy if collab.present?
    end
  end
end
