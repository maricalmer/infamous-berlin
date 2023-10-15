require 'rails_helper'

RSpec.describe Workflows::UserContext do
  describe "contact_info?" do
    let(:user_no_contact_info) { FactoryBot.build_stubbed(:user) }
    let(:user_with_website) { FactoryBot.build_stubbed(:user, website: "website.com") }
    let(:user_with_instagram) { FactoryBot.build_stubbed(:user, instagram: "my_instagram.com") }
    let(:user_with_twitter) { FactoryBot.build_stubbed(:user, twitter: "my_twitter.com") }
    it "is falsy when empty" do
      user_context = Workflows::UserContext.new(user_no_contact_info)
      expect(user_context.contact_info?).to be_falsy
    end
    it "is truthy when website field is present" do
      user_context = Workflows::UserContext.new(user_with_website)
      expect(user_context.contact_info?).to be_truthy
    end
    it "is truthy when instagram field is present" do
      user_context = Workflows::UserContext.new(user_with_instagram)
      expect(user_context.contact_info?).to be_truthy
    end
    it "is truthy when twitter field is present" do
      user_context = Workflows::UserContext.new(user_with_twitter)
      expect(user_context.contact_info?).to be_truthy
    end
  end

  describe "unread_messages?" do
    let(:author) { FactoryBot.create(:user) }
    let(:receiver) { FactoryBot.create(:user) }
    let(:chatroom) { FactoryBot.create(:chatroom, author: author, receiver: receiver) }
    let(:message) { FactoryBot.create(:message, chatroom: chatroom, user: author) }
    it "is truthy when message not read by receiver" do
      user_context = Workflows::UserContext.new(receiver)
      message
      expect(user_context.unread_messages?).to be_truthy
    end
    it "is falsy when message read by receiver" do
      user_context = Workflows::UserContext.new(receiver)
      message.read_by_receiver = true
      message.save
      expect(user_context.unread_messages?).to be_falsy
    end
  end

  describe "add default img if no img after account creation" do
    let(:user) { FactoryBot.create(:user) }
    it "returns default img name file" do
      expect(user.photo.filename.to_s).to match("default-profile-peep.png")
    end
  end

  describe "default_profile_pic?" do
    let(:user) { FactoryBot.create(:user) }
    it "is truthy when no profile pic uploaded" do
      user_context = Workflows::UserContext.new(user)
      expect(user_context.default_profile_pic?).to be_truthy
    end
    it "is falsy when profile pic uploaded" do
      user.photo.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "img_sample.jpeg")),
        filename: 'img_sample.jpeg',
        content_type: "image/jpeg"
      )
      user_context = Workflows::UserContext.new(user)
      expect(user_context.default_profile_pic?).to be_falsy
    end
  end

  describe "list_user_index" do
    let(:user) { FactoryBot.create(:user) }
    let(:user_with_bio) { FactoryBot.create(:user, bio: "bio") }
    it "returns 0 result if user has no written bio" do
      user_context = Workflows::UserContext.new(user)
      expect(user_context.list_profiles.size).to eq(0)
    end
    it "returns 1 result if user has written bio only" do
      user_context = Workflows::UserContext.new(user_with_bio)
      expect(user_context.list_profiles.size).to eq(1)
    end
    it "returns 1 results if 1 user has written bio only and 1 user has no written bio, 1st is with bio " do
      user_context = Workflows::UserContext.new(user)
      user_with_bio
      expect(user_context.list_profiles.size).to eq(1)
      expect(user_context.list_profiles.first).to eq(user_with_bio)
    end
  end

  describe "display_portfolio" do
    let(:user) { FactoryBot.create(:user) }
    it "returns no result if user has no project" do
      user_context = Workflows::UserContext.new(user)
      expect(user_context.display_portfolio.size).to eq(0)
    end
    let(:upcoming_project) { FactoryBot.build(:project, status: "upcoming", user: user) }
    it "returns no result if user has 1 upcoming project" do
      upcoming_project.attachments.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "img_sample.jpeg")),
        filename: 'img_sample.jpeg',
        content_type: "image/jpeg"
      )
      upcoming_project.save!
      user_context = Workflows::UserContext.new(user)
      expect(user_context.display_portfolio.size).to eq(0)
    end
    let(:past_project) { FactoryBot.build(:project, status: "past", user: user) }
    it "returns 1 result if user has 1 past project" do
      past_project.attachments.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "img_sample.jpeg")),
        filename: 'img_sample.jpeg',
        content_type: "image/jpeg"
      )
      past_project.save!
      user_context = Workflows::UserContext.new(user)
      expect(user_context.display_portfolio.size).to eq(1)
    end
  end

  describe "display_ongoing_projects" do
    let(:user) { FactoryBot.create(:user) }
    it "returns no result if user has no project" do
      user_context = Workflows::UserContext.new(user)
      expect(user_context.display_ongoing_projects.size).to eq(0)
    end
    let(:past_project) { FactoryBot.build(:project, status: "past", user: user) }
    it "returns no result if user has 1 past project" do
      past_project.attachments.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "img_sample.jpeg")),
        filename: 'img_sample.jpeg',
        content_type: "image/jpeg"
      )
      past_project.save!
      user_context = Workflows::UserContext.new(user)
      expect(user_context.display_ongoing_projects.size).to eq(0)
    end
    let(:upcoming_project) { FactoryBot.build(:project, status: "upcoming", user: user) }
    it "returns 1 result if user has 1 upcoming project" do
      upcoming_project.attachments.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "img_sample.jpeg")),
        filename: 'img_sample.jpeg',
        content_type: "image/jpeg"
      )
      upcoming_project.save!
      user_context = Workflows::UserContext.new(user)
      expect(user_context.display_ongoing_projects.size).to eq(1)
    end
  end
  describe "find_collab_within(project_id)" do
    let(:member) { FactoryBot.create(:user) }
    let(:first_project_owner) { FactoryBot.create(:user) }
    let(:second_project_owner) { FactoryBot.create(:user) }
    let(:first_project) { FactoryBot.create(:project) }
    let(:second_project) { FactoryBot.create(:project) }
    let(:first_collab) { FactoryBot.build(:collab) }
    let(:second_collab) { FactoryBot.build(:collab) }
    it "returns the right collab among several collabs" do
      first_collab.project = first_project
      first_collab.project.user = first_project_owner
      first_collab.member = member
      first_collab.save
      second_collab.project = second_project
      second_collab.project.user = second_project_owner
      second_collab.member = member
      second_collab.save
      user_context = Workflows::UserContext.new(member)
      expect(user_context.find_collab_within(first_project.id)).to eq(first_collab)
      expect(user_context.find_collab_within(second_project.id)).to eq(second_collab)
    end
  end
end
