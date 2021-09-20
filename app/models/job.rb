class Job < ApplicationRecord
  SKILLS_NEEDED = ["acting", "dancing", "photoshop"].freeze

  belongs_to :project

  validates :title, presence: true
  validates :deadline, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :not_before_start
  validates :description, presence: true
  validate :right_skills, unless: :no_skills_needed?

  private

  def right_skills
    errors.add(:skills_needed, "invalid skills") if (skills_needed - SKILLS_NEEDED).present?
  end

  def no_skills_needed?
    skills_needed.nil? || skills_needed.empty?
  end

  def not_before_start
    errors.add(:end_date, "end date cannot be before start date") if end_date.before?(start_date)
  end
end
