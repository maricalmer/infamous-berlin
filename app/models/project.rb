class Project < ApplicationRecord
  belongs_to :user
  has_many :mirrors, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :collabs, dependent: :destroy
  has_many :members, class_name: 'User', through: :collabs
  has_many_attached :attachments
  enum status: { past: "past", upcoming: "upcoming" }

  validates :title, uniqueness: true
  validates :title, presence: true, case_sensitive: false
  validates :description, presence: true
  validates :slug, :title, uniqueness: true, case_sensitive: false
  validates :attachments,
            content_type: {
              in: ['image/png', 'image/jpg', 'image/jpeg', 'video/mp4', 'audio/mpeg'],
              message: ' - wrong format (PNG, JPG, JPEG, MP3 or MP4 only)'
            },
            size: { less_than: 5.megabytes, message: '5MB max' },
            presence: true

  validates_length_of :attachments, maximum: 5, message: "5 files max"

  after_create :update_slug
  # after_create_commit :add_default_img
  after_create_commit :create_mirror
  before_update :assign_slug

  include Autocomplete
  include Slug
  include PgSearch::Model
  pg_search_scope :search_by_title_description_location_category, against: {
    title: "A",
    category: "A",
    description: "B",
    location: "B"
  }, using: {
    tsearch: { prefix: true, any_word: true }
  }

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

  # def add_default_img
  #   return if attachments.attached?

  #   attachments.attach(
  #     io: File.open(Rails.root.join("app", "assets", "images", "logo.png")),
  #     filename: 'logo.jpg',
  #     content_type: "image/jpg"
  #   )
  # end
end
