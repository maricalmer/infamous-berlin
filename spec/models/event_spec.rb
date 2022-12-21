require 'rails_helper'

RSpec.describe Event do
  describe "validations" do
    let(:event) { FactoryBot.create(:event) }
    let(:event_nil_title) { FactoryBot.build_stubbed(:event, title: nil) }
    let(:event_empty_string_title) { FactoryBot.build_stubbed(:event, title: "") }
    let(:event_special_character_title) { FactoryBot.build_stubbed(:event, title: ">") }
    let(:event_too_long_title) { FactoryBot.build_stubbed(:event, title: 'a' * 101) }
    let(:event_nil_description) { FactoryBot.build_stubbed(:event, description: nil) }
    let(:event_empty_string_description) { FactoryBot.build_stubbed(:event, description: "") }
    let(:event_special_character_description) { FactoryBot.build_stubbed(:event, description: "<") }
    it "is valid with title, description and date" do
      p event
      expect(event).to be_valid
    end
    it "is not valid with nil title" do
      expect(event_nil_title).to_not be_valid
    end
    it "is not valid with an empty string title" do
      expect(event_empty_string_title).to_not be_valid
    end
    it "is not valid with a special character in title" do
      expect(event_special_character_title).to_not be_valid
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
    it "is not valid with a special character in description" do
      expect(event_special_character_description).to_not be_valid
    end
    it "is not valid when slug is not unique" do
      second_event = Event.new(title: "title_second_event",
                                   description: "description_second_event",
                                   date: DateTime.now)
      second_event.slug = event.slug
      expect(second_event).to_not be_valid
      expect(second_event.errors.full_messages_for(:slug)).to include "Slug has already been taken"
    end
  end
end

