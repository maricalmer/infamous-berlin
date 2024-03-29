class Project < ApplicationRecord
  belongs_to :user
  has_many :mirrors, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :collabs, dependent: :destroy
  has_many :members, class_name: 'User', through: :collabs
  has_many_attached :attachments
  enum status: { past: "past", upcoming: "upcoming" }

  validates :title, uniqueness: true,
                    presence: true,
                    case_sensitive: false,
                    format: { without: /(<|>|&)/, message: "cannot include special characters" },
                    length: { maximum: 100, message: "is too long" }
  validates :description, presence: true, format: { without: /(<|>|&)/, message: "cannot include <, >, and &" }
  validates :slug, uniqueness: true, case_sensitive: false
  validates :attachments,
            content_type: {
              in: ['image/png', 'image/jpg', 'image/jpeg', 'video/mp4', 'audio/mpeg'],
              message: ' - wrong format (PNG, JPG, JPEG, MP3 or MP4 only)'
            },
            size: { less_than: 5.megabytes, message: '5MB max' },
            presence: true

  validates_length_of :attachments, maximum: 5, message: "5 files max"

  after_create :renew_slug
  after_create_commit :create_mirror
  before_update :set_slug

  include PgSearch::Model

  pg_search_scope :search_by_title_description_location_category, against: {
    title: "A",
    category: "A",
    description: "B",
    location: "B"
  }, using: {
    tsearch: { prefix: true, any_word: true }
  }

  def to_param
    slug
  end

  def self.list_projects_based_on(params)
    Workflows::ProjectSelector.new.custom_index(params)
  end

  private

  def set_slug
    Services::SlugGenerator.new(string: title, client: self).assign_slug
  end

  def renew_slug
    Services::SlugGenerator.new(string: title, client: self).update_slug
  end

  def create_mirror
    Mirror.create(user: user, project: self)
  end
end
