require 'rails_helper'

require "services/autocomplete_generator"

RSpec.describe AutocompleteGenerator do
  describe "usernames" do
    let(:first_user) { FactoryBot.create(:user) }
    let(:second_user) { FactoryBot.create(:user) }
    it "is valid with title and description" do
      first_user
      second_user
      autocomplete_generator = AutocompleteGenerator.new
      expect(autocomplete_generator.usernames).to eq([first_user.username, second_user.username])
    end
  end
end
