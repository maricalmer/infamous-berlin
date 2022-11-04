require 'rails_helper'

RSpec.describe Message do
  let(:chatroom) { FactoryBot.build_stubbed(:chatroom) }
  let(:user) { FactoryBot.build_stubbed(:user) }
  let(:message) { FactoryBot.build_stubbed(:message, chatroom: chatroom, user: user) }
  let(:nil_content_message) { FactoryBot.build_stubbed(:message, chatroom: chatroom, user: user, content: nil) }
  let(:empty_string_content_message) { FactoryBot.build_stubbed(:message, chatroom: chatroom, user: user, content: "") }
  describe "validations" do
    it "must be valid when it has content" do
      expect(message).to be_valid
    end
    it "must be invalid when it has nil content" do
      expect(nil_content_message).to_not be_valid
    end
    it "must be invalid when it has an empty string content" do
      expect(empty_string_content_message).to_not be_valid
    end
  end
end
