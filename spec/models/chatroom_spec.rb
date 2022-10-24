require 'rails_helper'

RSpec.describe Chatroom do
  let(:chatroom) { FactoryBot.create(:chatroom) }
  let(:user) { FactoryBot.create(:user) }
  describe "validations" do
    let(:first_message) { FactoryBot.create(:message, chatroom: chatroom, user: user) }
    let(:second_message) { FactoryBot.create(:message, chatroom: chatroom, user: user) }
    let(:third_message) { FactoryBot.create(:message, chatroom: chatroom, user: user) }
    it "contains messages listed in ascending order based on creation date" do
      first_message.chatroom = chatroom
      second_message.chatroom = chatroom
      third_message.chatroom = chatroom
      messages = chatroom.messages
      expect(messages.count).to eq(3)
      expect(messages.first).to eq(first_message)
      expect(messages[1]).to eq(second_message)
      expect(messages.last).to eq(third_message)
    end
    it "deletes the contained messages if chatroom is destroyed" do
      first_message.chatroom = chatroom
      messages = chatroom.messages
      chatroom.destroy
      expect(messages.count).to eq(0)
    end
    let(:alternative_chatroom) { FactoryBot.create(:chatroom) }
    it "lists chatrooms in ascending order based on update date" do
      chatroom
      alternative_chatroom
      chatrooms = Chatroom.all
      expect(chatrooms.count).to eq(2)
      expect(chatrooms.first).to eq(chatroom)
      expect(chatrooms.last).to eq(alternative_chatroom)
    end
    it "reorders the chatrooms when the first of the list gets updated" do
      chatroom
      alternative_chatroom.update!(updated_at: 1.hour.ago)
      chatrooms = Chatroom.all
      expect(chatrooms.count).to eq(2)
      expect(chatrooms.first).to eq(alternative_chatroom)
      expect(chatrooms.last).to eq(chatroom)
    end
    let(:second_chatroom) { FactoryBot.create(:chatroom) }
    let(:third_chatroom) { FactoryBot.create(:chatroom) }
    it "creates scope which return all chatrooms a user is part of" do
      chatroom
      second_chatroom.update(receiver_id: chatroom.author.id)
      third_chatroom
      chatrooms = Chatroom.participating(chatroom.author)
      expect(chatrooms.count).to eq(2)
      expect(chatrooms).to eq([chatroom, second_chatroom])
    end
  end
end
