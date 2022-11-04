require 'rails_helper'

RSpec.describe Chatroom do
  let(:chatroom) { FactoryBot.create(:chatroom) }
  let(:user) { FactoryBot.create(:user) }
  describe "validations" do
    let(:message) { FactoryBot.create(:message, chatroom: chatroom, user: user, content: "message is in chatroom") }
    before(:example) do
      message
    end
    it "contains messages listed in ascending order based on creation date" do
      expect(chatroom.messages.map(&:content)).to eq(["message is in chatroom"])
    end
    it "deletes the contained messages if chatroom is destroyed" do
      chatroom.destroy
      expect(chatroom.messages.count).to eq(0)
    end
    let(:old_chatroom) { FactoryBot.create(:chatroom, updated_at: 1.hour.ago) }
    let(:very_old_chatroom) { FactoryBot.create(:chatroom, updated_at: 2.hour.ago) }
    before(:example) do
      old_chatroom
      very_old_chatroom
    end
    it "lists chatrooms in ascending order based on update date" do
      chatrooms = Chatroom.all
      expect(chatrooms.count).to eq(3)
      expect(chatrooms[0]).to eq(chatroom)
      expect(chatrooms[1]).to eq(old_chatroom)
      expect(chatrooms[2]).to eq(very_old_chatroom)
    end
    it "reorders the chatrooms when the last of the list gets updated" do
      chatroom.update(updated_at: 3.hour.ago)
      chatrooms = Chatroom.all
      expect(chatrooms.count).to eq(3)
      expect(chatrooms[0]).to eq(old_chatroom)
      expect(chatrooms[1]).to eq(very_old_chatroom)
      expect(chatrooms[2]).to eq(chatroom)
    end
    it "creates scope which return all chatrooms a user is part of" do
      old_chatroom.update(receiver_id: chatroom.author.id)
      chatrooms = Chatroom.participating(chatroom.author)
      expect(chatrooms).to match_array([chatroom, old_chatroom])
    end
  end
end
