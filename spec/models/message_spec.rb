require 'rails_helper'

RSpec.describe Message do
  let(:chatroom) { FactoryBot.build_stubbed(:chatroom) }
  let(:user) { FactoryBot.build_stubbed(:user) }
  let(:message) { FactoryBot.build_stubbed(:message, chatroom: chatroom, user: user) }
  describe "validations" do
    it "must be valid when it has content" do
      message
      expect(message).to be_valid
    end
    it "must be invalid when it has no content" do
      message.content = nil
      expect(message).to_not be_valid
    end
  end
end
