require 'rails_helper'

RSpec.describe Workflows::EventContext do
  describe "add_to_attendees(user_id)" do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:event_with_user) { FactoryBot.create(:event, attendees: [user.id]) }
    let(:event_tomorrow) { FactoryBot.create(:event, date: 1.day.from_now) }
    it "adds user id to attendees array" do
      event_context = Workflows::EventContext.new(event)
      event_context.add_to_attendees(user.id)
      expect(event.attendees.count).to eq(1)
      expect(event.attendees).to eq([user.id])
    end
    it "does not add user id to attendees array if user id already present" do
      event_context = Workflows::EventContext.new(event_with_user)
      event_context.add_to_attendees(user.id)
      expect(event_with_user.attendees.count).to eq(1)
      expect(event_with_user.attendees).to eq([user.id])
    end
    it "removes user id to attendees array" do
      event_context = Workflows::EventContext.new(event_with_user)
      event_context.remove_from_attendees(user.id)
      expect(event_with_user.attendees.count).to eq(0)
    end
    it "creates an array of genres out of a string coma separated" do
      event.genre = "genre_1, genre_2"
      event_context = Workflows::EventContext.new(event)
      expect(event_context.format_genre_attribute).to eq(["genre_1", "genre_2"])
    end
    it "creates an array of genres out of a string space separated" do
      event.genre = "genre_1 genre_2"
      event_context = Workflows::EventContext.new(event)
      expect(event_context.format_genre_attribute).to eq(["genre_1", "genre_2"])
    end
    it "removes all autoplay options on embeded links" do
      event.media = "https://soundcloud.com/track&auto_play=true&auto_play=true"
      event_context = Workflows::EventContext.new(event)
      expect(event_context.format_media_attribute).to eq("https://soundcloud.com/track&auto_play=false&auto_play=false")
    end
    it "creates a calendar hash with dates as keys and parties for the date as values" do
      user
      event
      event_with_user
      event_tomorrow
      event_context = Workflows::EventContext.new(event)
      expect(event_context.new_calendar.keys.first).to eq(0.day.from_now.to_date)
      expect(event_context.new_calendar.keys.last).to eq(1.day.from_now.to_date)
      expect(event_context.new_calendar.values.first).to match_array([event, event_with_user])
      expect(event_context.new_calendar.values.last).to match_array([event_tomorrow])
    end
    it "validates when organizer has been tagged as 'random'" do
      event.organizer_type = "random"
      event_context = Workflows::EventContext.new(event)
      expect(event_context.is_organizer_random?).to be_truthy
    end
    it "does not validate when organizer has not been tagged as 'random'" do
      event.organizer_type = "friends"
      event_context = Workflows::EventContext.new(event)
      expect(event_context.is_organizer_random?).to be_falsy
    end
    it "validates when organizer has been tagged as 'infamous'" do
      event.organizer_type = "infamous"
      event_context = Workflows::EventContext.new(event)
      expect(event_context.is_organizer_infamous?).to be_truthy
    end
    it "does not validate when organizer has not been tagged as 'infamous'" do
      event_context = Workflows::EventContext.new(event)
      expect(event_context.is_organizer_infamous?).to be_falsy
    end
    it "validates when organizer has been tagged as 'friends'" do
      event.organizer_type = "friends"
      event_context = Workflows::EventContext.new(event)
      expect(event_context.is_organizer_friends?).to be_truthy
    end
    it "does not validate when organizer has not been tagged as 'friends'" do
      event_context = Workflows::EventContext.new(event)
      expect(event_context.is_organizer_friends?).to be_falsy
    end
  end
end
