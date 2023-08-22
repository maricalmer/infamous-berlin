class Workflows::EventContext
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def add_to_attendees(user_id)
    return if @event.attendees.include?(user_id)

    @event.attendees.push(user_id)
  end

  def remove_from_attendees(user_id)
    return if !@event.attendees.include?(user_id)

    @event.attendees.delete(user_id)
  end

  def format_genre_attribute
    @event.genre.gsub(/,/, ' ').strip.split(' ')
  end

  def format_media_attribute
    @event.media = @event.media.gsub(/&auto_play=true/, "&auto_play=false") if @event.media
  end

  def new_calendar
    days = []
    (0...30).each { |d| days << d.day.from_now.to_date }
    calendar = {}
    days.each do |d|
      events_on_day = Event.where("date BETWEEN ? AND ?", d.at_beginning_of_day, d.at_end_of_day ).order('coalesce(array_length(attendees, 1), 0)').reverse
      calendar[d] = events_on_day if events_on_day.present?
    end
    return calendar
  end

  def is_organizer_infamous?
    @event.organizer_type == "infamous"
  end

  def is_organizer_friends?
    @event.organizer_type == "friends"
  end

  def is_organizer_random?
    @event.organizer_type == "random"
  end
end
