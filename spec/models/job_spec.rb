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
  describe "filter_jobs_on(payment_type)" do
    let(:second_job) { FactoryBot.create(:job, payment: "hourly_rate") }
    let(:third_job) { FactoryBot.create(:job, payment: "fixed_rate") }
    it "returns jobs for hourly_rate" do
      job
      second_job
      third_job
      jobs = Job.filter_jobs_on("hourly_rate")
      expect(jobs.count).to eq(2)
      expect(jobs).to eq([job, second_job])
    end
    it "returns a job for fixed_rate" do
      job
      second_job
      third_job
      jobs = Job.filter_jobs_on("fixed_rate")
      expect(jobs.count).to eq(1)
      expect(jobs).to eq([third_job])
    end
  end
  describe "active_offer?(current_user)" do
    let(:stubbed_project) { FactoryBot.build_stubbed(:project) }
    let(:stubbed_user) { FactoryBot.build_stubbed(:user) }
    it "tells that current_user can apply to the offer when offer status is open" do
      stubbed_user
      job
      expect(job.active_offer?(stubbed_user)).to be_truthy
    end
    it "tells that current_user cannot apply to the offer when offer status is close" do
      stubbed_user
      job
      job.status = "close"
      expect(job.active_offer?(stubbed_user)).to be_falsy
    end
    it "tells that current_user cannot apply to the offer when he owns the offer" do
      stubbed_project.user = stubbed_user
      job.project = stubbed_project
      expect(job.active_offer?(stubbed_user)).to be_falsy
    end
  end
end
