class Event < ApplicationRecord
  has_one_attached :photo

  validates :photo, size: { less_than: 5.megabytes, message: '5MB max' }
  validates :title, presence: true,
                    case_sensitive: false,
                    length: { maximum: 100, message: "is too long" }
  validates :description, presence: true
  validates :slug, uniqueness: true, case_sensitive: false

  after_create :renew_slug
  before_update :set_slug

  def to_param
    slug
  end

  private

  def set_slug
    Services::SlugGenerator.new(string: title, client: self).assign_slug
  end

  def renew_slug
    Services::SlugGenerator.new(string: title, client: self).update_slug
  end
end
