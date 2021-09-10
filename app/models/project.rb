class Project < ApplicationRecord
  belongs_to :user
  has_many :applications
  has_many_attached :photos

  after_create :update_slug
  before_update :assign_slug

  validates :title, presence: true, uniqueness: true, case_sensitive: false
  validates :slug, :title, uniqueness: true, case_sensitive: false

  enum status: { portfolio: "portfolio", upcoming: "upcoming", deleted: "deleted" }
  # ^^ rename portfolio status as past

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
