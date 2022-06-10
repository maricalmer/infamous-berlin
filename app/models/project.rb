class Project < ApplicationRecord
  belongs_to :user
  has_many :applications
  # ^^ old inquiry??
  has_many :mirrors, dependent: :destroy
  has_many :jobs
  has_many :collabs
  has_many :members, class_name: 'User', through: :collabs
  has_many_attached :attachments
  enum status: { past: "past", upcoming: "upcoming" }

  validates :title, presence: true, uniqueness: true, case_sensitive: false
  validates :description, presence: true
  validates :slug, :title, uniqueness: true, case_sensitive: false
  validates :attachments, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg', 'video/mp4', 'audio/mpeg'], message: ' - wrong format (PNG, JPG, JPEG, MP3 or MP4 only)' }, size: { less_than: 5.megabytes , message: '5MB max' }

  after_create :update_slug
  after_create_commit :create_mirror
  before_update :assign_slug

  include PgSearch::Model
  pg_search_scope :search_by_title_description_location_category, against: {
    title: "A",
    category: "A",
    description: "B",
    location: "B"
  }, using: {
    tsearch: { prefix: true, any_word: true }
  }

  def project_locations
    ["Kreuzberg", "Mitte", "Wedding", "P.Berg", "Neukölln", "Friedrichshain"]
  end

  def project_categories
    ['painting', 'print', 'photography', 'sculpture', 'furniture', 'fashion', 'other']
  end

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

  def render_categories
    category.split.map { |cat| cat.gsub("_", " ") }
  end

  # def video_attachments?
  #   attachments.each { |attachment| attachment.video? }.any?(true)
  # end

  private

  def create_mirror
    Mirror.create(user: user, project: self)
  end

  def add_default_img
    return if attachments.attached?

    attachments.attach(
      io: File.open(Rails.root.join("app", "assets", "images", "logo.png")),
      filename: 'logo.jpg',
      content_type: "image/jpg"
    )
  end

  def assign_slug
    self.slug = create_slug
  end
end
