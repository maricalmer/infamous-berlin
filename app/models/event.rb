class Event < ApplicationRecord
  has_one_attached :photo

  validates :photo, size: { less_than: 5.megabytes, message: '5MB max' }
  validates :title, presence: true,
                    case_sensitive: false,
                    length: { maximum: 100, message: "is too long" }
  validates :organizer_type, inclusion: { in: %w(infamous friends random), message: "%{value} is not a valid type, please choose: infamous, friends or random" }
  validates :description, presence: true
  validates :slug, uniqueness: true, case_sensitive: false

  before_save :remove_iframes_autoplay
  after_create :renew_slug
  before_update :set_slug


  def to_param
    slug
  end

  def attend(user_id)
    Workflows::EventContext.new(self).add_to_attendees(user_id)
  end

  def unattend(user_id)
    Workflows::EventContext.new(self).remove_from_attendees(user_id)
  end

  def split_genre_items
    Workflows::EventContext.new(self).format_genre_attribute
  end

  def self.create_calendar
    Workflows::EventContext.new(nil).new_calendar
  end

  def infamous?
    Workflows::EventContext.new(self).is_organizer_infamous?
  end

  def friends?
    Workflows::EventContext.new(self).is_organizer_friends?
  end

  def random?
    Workflows::EventContext.new(self).is_organizer_random?
  end

  private

  def set_slug
    Services::SlugGenerator.new(string: title, client: self).assign_slug
  end

  def renew_slug
    Services::SlugGenerator.new(string: title, client: self).update_slug
  end

  def remove_iframes_autoplay
    Workflows::EventContext.new(self).format_media_attribute
  end
end
