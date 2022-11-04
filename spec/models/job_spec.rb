require 'rails_helper'

RSpec.describe Job do
  let(:job) { FactoryBot.create(:job) }
  let(:nil_title_job) { FactoryBot.build_stubbed(:job, title: nil) }
  let(:empty_string_title_job) { FactoryBot.build_stubbed(:job, title: "") }
  let(:nil_description_job) { FactoryBot.build_stubbed(:job, description: nil) }
  let(:empty_string_description_job) { FactoryBot.build_stubbed(:job, description: "") }
  let(:nil_money_job) { FactoryBot.build_stubbed(:job, money: nil) }
  let(:negative_money_job) { FactoryBot.build_stubbed(:job, money: -10) }
  describe "validations" do
    it "must be valid when it has title, description and money" do
      expect(job).to be_valid
    end
    it "must be invalid when it has nil title" do
      expect(nil_title_job).to_not be_valid
    end
    it "must be invalid when it has an empty string title" do
      expect(empty_string_title_job).to_not be_valid
    end
    it "must be invalid when it has nil description" do
      expect(nil_description_job).to_not be_valid
    end
    it "must be invalid when it has an empty string description" do
      expect(empty_string_description_job).to_not be_valid
    end
    it "must be invalid when money is nil" do
      expect(nil_money_job).to_not be_valid
    end
    it "must be invalid when money is negative" do
      expect(negative_money_job).to_not be_valid
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
    before(:example) do
      job
      second_job
      third_job
    end
    let(:second_job) { FactoryBot.create(:job, payment: "hourly_rate") }
    let(:third_job) { FactoryBot.create(:job, payment: "fixed_rate") }
    it "returns jobs for hourly_rate" do
      jobs = Job.filter_jobs_on("hourly_rate")
      expect(jobs).to match_array([job, second_job])
    end
    it "returns a job for fixed_rate" do
      jobs = Job.filter_jobs_on("fixed_rate")
      expect(jobs).to eq([third_job])
    end
  end
  describe "active_offer?(current_user)" do
    let(:stubbed_project) { FactoryBot.build_stubbed(:project) }
    let(:stubbed_user) { FactoryBot.build_stubbed(:user) }
    before(:example) do
      stubbed_user
      job
    end
    it "tells that current_user can apply to the offer when offer status is open" do
      expect(job.active_offer?(stubbed_user)).to be_truthy
    end
    it "tells that current_user cannot apply to the offer when offer status is close" do
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
