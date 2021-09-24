class Project < ApplicationRecord
  belongs_to :user
  has_many :applications
  has_many :jobs
  has_many_attached :photos

  after_create :update_slug
  before_update :assign_slug

  validates :title, presence: true, uniqueness: true, case_sensitive: false
  validates :slug, :title, uniqueness: true, case_sensitive: false

  enum status: { past: "past", upcoming: "upcoming", deleted: "deleted" }

  include PgSearch::Model
  pg_search_scope :search_by_title_and_description_and_location, against: {
    title: "A",
    description: "B",
    location: "B"
  }, using: {
    tsearch: { prefix: true, any_word: true }
  }

  def create_slug
    slug = self.title.parameterize
    Project.where.not(id: self.id).find_by(slug: slug).nil? ? slug : slug + slug.length.to_s
  end

  def update_slug
    update slug: assign_slug
  end

  def to_param
    slug
  end

  private

  def assign_slug
    self.slug = create_slug
  end
end
