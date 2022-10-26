require 'rails_helper'

RSpec.describe Inquiry do
  describe "validations" do
    let(:inquiry) { FactoryBot.build_stubbed(:inquiry) }
    it "must be valid when it has content" do
      inquiry
      expect(inquiry).to be_valid
    end
    it "must include motivation text of 10 characters min" do
      inquiry.motivation = nil
      expect(inquiry).to_not be_valid
      expect(inquiry.errors.full_messages_for(:motivation)).to include "Motivation can't be blank"
    end
    it "must include experience text of 10 characters min" do
      inquiry.motivation = "123"
      expect(inquiry).to_not be_valid
      expect(inquiry.errors.full_messages_for(:motivation)).to include "Motivation 10 characters minimum"
    end
    it "must restrict users to apply several times to the same job" do
      inquiry.experience = nil
      expect(inquiry).to_not be_valid
      expect(inquiry.errors.full_messages_for(:experience)).to include "Experience can't be blank"
    end
    it "must restrict users to apply several times to the same job" do
      inquiry.experience = "123"
      expect(inquiry).to_not be_valid
      expect(inquiry.errors.full_messages_for(:experience)).to include "Experience 10 characters minimum"
    end
  end
  describe "update_collabs(status)" do
    let(:persisted_inquiry) { FactoryBot.create(:inquiry) }
    it "deletes no collab when inquiry status is initially rejected" do
      persisted_inquiry.update(status: "rejected")
      persisted_inquiry.update_collabs("rejected")
      collabs = Collab.all
      expect(collabs.count).to eq(0)
    end
    it "creates a collab when inquiry status is initially accepted" do
      persisted_inquiry.update(status: "accepted")
      persisted_inquiry.update_collabs("accepted")
      collabs = Collab.all
      expect(collabs.count).to eq(1)
      expect(collabs.first.project).to eq(persisted_inquiry.job.project)
      expect(collabs.first.user_id).to eq(persisted_inquiry.user.id)
    end
    it "deletes a collab when inquiry status switches from accepted to rejected" do
      persisted_inquiry.update(status: "accepted")
      persisted_inquiry.update_collabs("accepted")
      persisted_inquiry.update(status: "rejected")
      persisted_inquiry.update_collabs("rejected")
      collabs = Collab.all
      expect(collabs.count).to eq(0)
    end
    it "creates a collab when inquiry status switches from rejected to accepted" do
      persisted_inquiry.update(status: "rejected")
      persisted_inquiry.update_collabs("rejected")
      persisted_inquiry.update(status: "accepted")
      persisted_inquiry.update_collabs("accepted")
      collabs = Collab.all
      expect(collabs.count).to eq(1)
      expect(collabs.first.project).to eq(persisted_inquiry.job.project)
      expect(collabs.first.user_id).to eq(persisted_inquiry.user.id)
    end
  end
end
