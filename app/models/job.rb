class Job < ApplicationRecord
  belongs_to :project
  has_many :inquiries
  validates :title, presence: true
  validates :description, presence: true
  validates :money, presence: true, numericality: { greater_than_or_equal_to: 0, message: "value must be positive" }

  enum payment: { fixed_rate: "fixed_rate", hourly_rate: "hourly_rate" }
  enum status: { open: "open", close: "close" }

  require "services/tags_renderer"
  include PgSearch::Model

  pg_search_scope :search_by_title_description_skills, against: {
    title: "A",
    skills_needed: "A",
    description: "B"
  }, using: {
    tsearch: { prefix: true, any_word: true }
  }

  def applied?(current_user)
    applicants = inquiries.map(&:user)
    applicants.include? current_user
  end

  def display_skills
    TagsRenderer.new(skills_needed).format_tags
  end

  def self.filter_jobs_on(payment_type)
    Job.where(payment: payment_type)
  end

  def active_offer?(current_user)
    project.user != current_user && open?
  end
end
