require 'rails_helper'

RSpec.describe Services::AutocompleteGenerator do
  describe "usernames" do
    let(:first_user) { FactoryBot.create(:user) }
    let(:second_user) { FactoryBot.create(:user) }
    before(:example) do
      first_user
      second_user
    end
    it "is valid with title and description" do
      autocomplete_generator = Services::AutocompleteGenerator.new
      expect(autocomplete_generator.usernames).to eq([first_user.username, second_user.username])
    end
  end
end
