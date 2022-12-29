require 'rails_helper'

RSpec.describe Event do
  describe "validations" do
    let(:event) { FactoryBot.create(:event) }
    let(:event_nil_title) { FactoryBot.build_stubbed(:event, title: nil) }
    let(:event_empty_string_title) { FactoryBot.build_stubbed(:event, title: "") }
    let(:event_too_long_title) { FactoryBot.build_stubbed(:event, title: 'a' * 101) }
    let(:event_nil_description) { FactoryBot.build_stubbed(:event, description: nil) }
    let(:event_empty_string_description) { FactoryBot.build_stubbed(:event, description: "") }
    it "is valid with title, description and date" do
      expect(event).to be_valid
    end
    it "is not valid with nil title" do
      expect(event_nil_title).to_not be_valid
    end
    it "is not valid with an empty string title" do
      expect(event_empty_string_title).to_not be_valid
    end
    it "is not valid with a title over 100 characters" do
      expect(event_too_long_title).to_not be_valid
    end
    it "is not valid with nil description" do
      expect(event_nil_description).to_not be_valid
    end
    it "is not valid with an empty string description" do
      expect(event_empty_string_description).to_not be_valid
    end
    it "is not valid when slug is not unique" do
      second_event = Event.new(title: "title_second_event",
                                   description: "description_second_event",
                                   date: DateTime.now)
      second_event.slug = event.slug
      expect(second_event).to_not be_valid
      expect(second_event.errors.full_messages_for(:slug)).to include "Slug has already been taken"
    end
    it "defaults to 0 attendee" do
      expect(event.attendees.count).to eq(0)
    end
  end
  describe "callbacks" do
    let(:event) { FactoryBot.create(:event) }
    let(:user) { FactoryBot.create(:user) }
    it "adds 1 attendee when attend method is called and user is not attending already" do
      event.attend(user.id)
      expect(event.attendees.count).to eq(1)
    end
    it "doesnt add 1 attendee when attend method is called but user is already attending" do
      event.attend(user.id)
      event.attend(user.id)
      expect(event.attendees.count).to eq(1)
    end
    it "removes 1 attendee when unattend method is called" do
      event.attend(user.id)
      expect(event.attendees.count).to eq(1)
      event.unattend(user.id)
      expect(event.attendees.count).to eq(0)
    end
    it "doesnt remove 1 attendee when unattend method is called but user is not attending" do
      event.unattend(user.id)
      expect(event.attendees.count).to eq(0)
    end
    it "removes all autoplay options on embeded links" do
      event.media = "https://soundcloud.com/track&auto_play=true&auto_play=true"
      event.save
      expect(event.media).to eq("https://soundcloud.com/track&auto_play=false&auto_play=false")
    end
  end
end

