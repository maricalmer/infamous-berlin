class Job < ApplicationRecord
  PAYMENT = ["hourly_rate", "fixed_rate"].freeze

  belongs_to :project
  has_many :inquiries, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validate :right_payment, unless: :no_payment_type?

  enum payment: { fixed_rate: "fixed rate", hourly_rate: "hourly rate" }
  enum status: { open: "open", close: "close" }

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

  def overall_skill_set
    ["acting", "voice acting", "singing", "oil painting", "acrylic painting", "digital painting", "3d drawing", "music producing", "dancing", "film editing", "film production", "video animation", "video design", "photography", "model"]
  end

  private

  def right_payment
    errors.add(:payment, "invalid payment type") if ([payment] - PAYMENT).present?
  end

  def no_payment_type?
    payment.empty?
  end
end
