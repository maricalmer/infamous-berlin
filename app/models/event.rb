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
    return if attendees.include?(user_id)

    attendees.push(user_id)
  end

  def unattend(user_id)
    return if !attendees.include?(user_id)

    attendees.delete(user_id)
  end

  def split_genre_items
    genre.gsub(/,/, ' ').strip.split(' ')
  end

  def self.create_calendar
    days = []
    (0...14).each { |d| days << d.day.from_now.to_date }
    calendar = {}
    days.each do |d|
      events_on_day = Event.where("date BETWEEN ? AND ?", d.at_beginning_of_day, d.at_end_of_day ).order('coalesce(array_length(attendees, 1), 0)').reverse
      calendar[d] = events_on_day if events_on_day.present?
    end
    return calendar
  end

  private

  def set_slug
    Services::SlugGenerator.new(string: title, client: self).assign_slug
  end

  def renew_slug
    Services::SlugGenerator.new(string: title, client: self).update_slug
  end

  def remove_iframes_autoplay
    self.media = media.gsub(/&auto_play=true/, "&auto_play=false") if media
  end
end
