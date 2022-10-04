class Job < ApplicationRecord
  # PAYMENT = ["hourly_rate", "fixed_rate"].freeze

  belongs_to :project
  has_many :inquiries, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :money, presence: true

  enum payment: { fixed_rate: "fixed_rate", hourly_rate: "hourly_rate" }
  enum status: { open: "open", close: "close" }

  scope :fixed_rate, -> { where(payment: "fixed_rate") }
  scope :hourly_rate, -> { where(payment: "hourly_rate") }
  # ^^ are the scopes needed??

  include Autocomplete
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

  def self.overall_skill_set
    skill_set
  end

  def self.locations
    location_set
  end

  def display_skills_needed
    return [] if skills_needed.nil?

    skills_needed.split.map do |skill|
      skill.include?("_") ? skill.gsub("_", " ") : skill
    end
  end

  # def right_payment
  #   errors.add(:payment, "invalid payment type") if ([payment] - PAYMENT).present?
  # end

  # def no_payment_type?
  #   payment.empty?
  # end
end
