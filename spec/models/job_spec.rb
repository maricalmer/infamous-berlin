require 'rails_helper'

RSpec.describe Job do
  let(:job) { FactoryBot.create(:job) }
  describe "validations" do
    it "must be valid when it has title, description and money" do
      job
      expect(job).to be_valid
    end
    it "must be invalid when it has no title" do
      job.title = nil
      expect(job).to_not be_valid
    end
    it "must be invalid when it has no description" do
      job.description = nil
      expect(job).to_not be_valid
    end
    it "must be invalid when it has no money" do
      job.money = nil
      expect(job).to_not be_valid
    end
  end
  describe "applied?(current_user)" do
    let(:user) { FactoryBot.build(:user) }
    let(:inquiry) { FactoryBot.create(:inquiry, user: user, job: job) }
    it "checks if user applied to job" do
      expect(job.applied?(user)).to be_falsy
    end
    it "checks if user applied to job" do
      inquiry
      expect(job.applied?(user)).to be_truthy
    end
  end
end
