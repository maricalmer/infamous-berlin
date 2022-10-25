require 'rails_helper'

Chatroom.new
RSpec.describe ChatroomContext do
  let(:chatroom) { FactoryBot.build_stubbed(:chatroom) }
  let(:user) { FactoryBot.build_stubbed(:user) }
  describe "find_other_participant(user)" do
    it "returns other chat participant if one of the two participants is passed as arg - author" do
      chatroom_context = ChatroomContext.new(chatroom)
      expect(chatroom_context.find_other_participant(chatroom.author)).to eq(chatroom.receiver)
    end
    it "returns other chat participant if one of the two participants is passed as arg - receiver" do
      chatroom_context = ChatroomContext.new(chatroom)
      expect(chatroom_context.find_other_participant(chatroom.receiver)).to eq(chatroom.author)
    end
    it "returns other chat participant if one of the two participants is passed as arg - none participant" do
      chatroom_context = ChatroomContext.new(chatroom)
      user
      expect(chatroom_context.find_other_participant(user)).to be_falsy
    end
  end
  describe "participates?(user)" do
    it "checks if a user is part of a specific chat - author" do
      chatroom_context = ChatroomContext.new(chatroom)
      expect(chatroom_context.participates?(chatroom.author)).to be_truthy
    end
    it "checks if a user is part of a specific chat - receiver" do
      chatroom_context = ChatroomContext.new(chatroom)
      expect(chatroom_context.participates?(chatroom.receiver)).to be_truthy
    end
    it "checks if a user is part of a specific chat - none participant" do
      chatroom_context = ChatroomContext.new(chatroom)
      user
      expect(chatroom_context.participates?(user)).to be_falsy
    end
  end
  describe "author_receiver_pair_must_be_unique" do
    let(:first_chatroom) { FactoryBot.create(:chatroom) }
    let(:second_chatroom) { FactoryBot.build(:chatroom, author: first_chatroom.author, receiver: first_chatroom.receiver) }
    let(:third_chatroom) { FactoryBot.build(:chatroom, author: first_chatroom.receiver, receiver: first_chatroom.author) }
    it "validates that author/receiver pair is unique - same attributes" do
      chatroom_context = ChatroomContext.new(second_chatroom)
      chatroom_context.author_receiver_pair_must_be_unique
      expect(second_chatroom).to_not be_valid
      expect(second_chatroom.errors.full_messages_for(:author_id)).to include "Author conversation already exists"
    end
    it "validates that author/receiver pair is unique - opposite attributes" do
      chatroom_context = ChatroomContext.new(third_chatroom)
      chatroom_context.author_receiver_pair_must_be_unique
      expect(third_chatroom).to_not be_valid
      expect(third_chatroom.errors.full_messages_for(:author_id)).to include "Author conversation already exists"
    end
  end
  let(:message_author) { FactoryBot.build(:user) }
  let(:message_receiver) { FactoryBot.build(:user) }
  let(:main_chatroom) { FactoryBot.build(:chatroom, author: message_author, receiver: message_receiver) }
  let(:first_chatroom_message) { FactoryBot.create(:message, chatroom: main_chatroom, user: message_author) }
  let(:second_chatroom_message) { FactoryBot.create(:message, chatroom: main_chatroom, user: message_author) }
  let(:other_message) { FactoryBot.create(:message, chatroom: alternative_chatroom, user: alternative_user) }
  describe "set_messages" do
    it "returns the chatroom messages" do
      first_chatroom_message
      second_chatroom_message
      chatroom_context = ChatroomContext.new(main_chatroom)
      messages = chatroom_context.set_messages
      expect(messages.count).to eq(2)
      expect(messages.first).to eq(first_chatroom_message)
      expect(messages.last).to eq(second_chatroom_message)
    end
  end
  describe "mark_messages_as_read(messages, user)" do
    let(:alternative_chatroom) { FactoryBot.build(:chatroom, author: user, receiver: message_receiver) }
    let(:alternative_user) { FactoryBot.build(:user) }
    it "updates the read_by_receiver attribute to true" do
      first_chatroom_message
      second_chatroom_message
      chatroom_context = ChatroomContext.new(main_chatroom)
      messages = chatroom_context.set_messages
      chatroom_context.mark_messages_as_read(messages, message_receiver)
      expect(messages.count).to eq(2)
      expect(messages.first.read_by_receiver).to be_truthy
      expect(messages.last.read_by_receiver).to be_truthy
      expect(other_message.read_by_receiver).to be_falsy
    end
  end
end
