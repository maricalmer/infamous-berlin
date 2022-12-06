require 'rails_helper'

RSpec.describe Inquiry do
  let(:inquiry) { FactoryBot.create(:inquiry) }
  describe "validations" do
    let(:second_inquiry) { FactoryBot.build_stubbed(:inquiry, job: inquiry.job, user: inquiry.user) }
    let(:empty_string_motivation_inquiry) { FactoryBot.build_stubbed(:inquiry, motivation: "") }
    let(:nil_motivation_inquiry) { FactoryBot.build_stubbed(:inquiry, motivation: nil) }
    let(:short_motivation_inquiry) { FactoryBot.build_stubbed(:inquiry, motivation: "123") }
    let(:special_character_motivation_inquiry) { FactoryBot.build_stubbed(:inquiry, motivation: "<") }
    let(:empty_string_experience_inquiry) { FactoryBot.build_stubbed(:inquiry, experience: "") }
    let(:nil_experience_inquiry) { FactoryBot.build_stubbed(:inquiry, experience: nil) }
    let(:short_experience_inquiry) { FactoryBot.build_stubbed(:inquiry, experience: "123") }
    let(:special_character_experience_inquiry) { FactoryBot.build_stubbed(:inquiry, experience: ">") }
    it "must be valid when it has content" do
      expect(inquiry).to be_valid
    end
    it "must be invalid when it has nil motivation" do
      expect(nil_motivation_inquiry).to_not be_valid
    end
    it "must be invalid when it has empty string motivation" do
      expect(empty_string_motivation_inquiry).to_not be_valid
    end
    it "must include motivation text of 10 characters min" do
      expect(short_motivation_inquiry).to_not be_valid
    end
    it "must be invalid when it has special characters in motivation" do
      expect(special_character_motivation_inquiry).to_not be_valid
    end
    it "must be invalid when it has nil experience" do
      expect(nil_experience_inquiry).to_not be_valid
    end
    it "must be invalid when it has empty string experience" do
      expect(empty_string_experience_inquiry).to_not be_valid
    end
    it "must include experience text of 10 characters min" do
      expect(short_experience_inquiry).to_not be_valid
    end
    it "must be invalid when it has special characters in experience" do
      expect(special_character_experience_inquiry).to_not be_valid
    end
    it "must restrict users to apply several times to the same job" do
      expect(second_inquiry).to_not be_valid
    end
  end
  describe "update_collabs(status)" do
    it "deletes no collab when inquiry status is initially rejected" do
      inquiry.update(status: "rejected")
      inquiry.update_collabs("rejected")
      collabs = Collab.all
      expect(collabs.count).to eq(0)
    end
    it "creates a collab when inquiry status is initially accepted" do
      inquiry.update(status: "accepted")
      inquiry.update_collabs("accepted")
      collabs = Collab.all
      expect(collabs.count).to eq(1)
      expect(collabs.first.project).to eq(inquiry.job.project)
      expect(collabs.first.user_id).to eq(inquiry.user.id)
    end
    it "deletes a collab when inquiry status switches from accepted to rejected" do
      inquiry.update(status: "accepted")
      inquiry.update_collabs("accepted")
      inquiry.update(status: "rejected")
      inquiry.update_collabs("rejected")
      collabs = Collab.all
      expect(collabs.count).to eq(0)
    end
    it "creates a collab when inquiry status switches from rejected to accepted" do
      inquiry.update(status: "rejected")
      inquiry.update_collabs("rejected")
      inquiry.update(status: "accepted")
      inquiry.update_collabs("accepted")
      collabs = Collab.all
      expect(collabs.count).to eq(1)
      expect(collabs.first.project).to eq(inquiry.job.project)
      expect(collabs.first.user_id).to eq(inquiry.user.id)
    end
  end
end
