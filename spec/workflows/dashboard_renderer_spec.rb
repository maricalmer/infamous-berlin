require 'rails_helper'

RSpec.describe Workflows::DashboardRenderer do
  let(:user) { FactoryBot.build(:user) }
  let(:other_user) { FactoryBot.build(:user) }
  let(:upcoming_project) { FactoryBot.create(:project, status: "upcoming", user: user) }
  let(:past_project) { FactoryBot.create(:project, status: "past", user: user) }
  describe "projects_for(user, status)" do
    before(:example) do
      user
      other_user
      upcoming_project
      past_project
    end
    it "returns 1 project owned by user when status is set to upcoming" do
      upcoming_project_from_user = Workflows::DashboardRenderer.new.projects_for(user, "upcoming")
      expect(upcoming_project_from_user).to eq([upcoming_project])
    end
    it "returns 1 project owned by user when status is set to past" do
      past_project_from_user = Workflows::DashboardRenderer.new.projects_for(user, "past")
      expect(past_project_from_user).to eq([past_project])
    end
    it "returns 0 project owned by other_user when status is set to upcoming" do
      upcoming_project_from_other_user = Workflows::DashboardRenderer.new.projects_for(other_user, "upcoming")
      expect(upcoming_project_from_other_user.count).to eq(0)
    end
  end
  describe "jobs_for(project_ids, status)" do
    let(:open_job) { FactoryBot.create(:job, project: upcoming_project) }
    let(:close_job) { FactoryBot.create(:job, project: upcoming_project, status: "close") }
    before(:example) do
      user
      upcoming_project
      open_job
      close_job
    end
    it "returns 1 job offer from upcoming or past project and of open status" do
      open_job_from_upcoming_project = Workflows::DashboardRenderer.new.jobs_for([upcoming_project.id, past_project.id], "open")
      expect(open_job_from_upcoming_project).to eq([open_job])
    end
    it "returns 1 job offer from upcoming or past project and of close status" do
      close_job_from_upcoming_project = Workflows::DashboardRenderer.new.jobs_for([upcoming_project.id, past_project.id], "close")
      expect(close_job_from_upcoming_project).to eq([close_job])
    end
    let(:second_open_job) { FactoryBot.create(:job, project: past_project) }
    it "returns 2 job offers from upcoming or past project and of open status" do
      past_project
      second_open_job
      open_jobs_from_upcoming_project_and_past_project = Workflows::DashboardRenderer.new.jobs_for([upcoming_project.id, past_project.id], "open")
      expect(open_jobs_from_upcoming_project_and_past_project).to match_array([open_job, second_open_job])
    end
  end
  describe "project_collabs_for(user, status)" do
    let(:member_upcoming_project) { FactoryBot.create(:project, status: "upcoming") }
    let(:upcoming_collab) { FactoryBot.create(:collab, project_id: member_upcoming_project.id, member: user) }
    before(:example) do
      user
    end
    it "returns 1 upcoming project in which user is a member" do
      member_upcoming_project
      upcoming_collab
      member_projects = Workflows::DashboardRenderer.new.project_collabs_for(user, "upcoming")
      expect(member_projects).to eq([member_upcoming_project])
    end
    let(:member_past_project) { FactoryBot.create(:project, status: "past") }
    let(:past_collab) { FactoryBot.create(:collab, project_id: member_past_project.id, member: user) }
    it "returns 1 past project in which user is a member" do
      member_past_project
      past_collab
      member_projects = Workflows::DashboardRenderer.new.project_collabs_for(user, "past")
      expect(member_projects).to eq([member_past_project])
    end
    let(:second_member_past_project) { FactoryBot.create(:project, status: "past") }
    let(:second_past_collab) { FactoryBot.create(:collab, project_id: second_member_past_project.id, member: user) }
    it "returns 2 past projects in which user is a member" do
      member_past_project
      second_member_past_project
      past_collab
      second_past_collab
      member_projects = Workflows::DashboardRenderer.new.project_collabs_for(user, "past")
      expect(member_projects).to match_array([member_past_project, second_member_past_project])
    end
  end
  let(:first_job) { FactoryBot.create(:job, project: upcoming_project) }
  let(:first_inquiry) { FactoryBot.create(:inquiry, job: first_job, status: "accepted") }
  let(:second_job) { FactoryBot.create(:job, project: upcoming_project) }
  let(:second_inquiry) { FactoryBot.create(:inquiry, job: second_job, status: "rejected") }
  describe "received_inquiries_for(job_ids, status)" do
    before(:example) do
      first_inquiry
    end
    it "returns 1 received accepted inquiry for specified job" do
      first_job
      second_job
      second_inquiry
      inquiries = Workflows::DashboardRenderer.new.received_inquiries_for([first_job.id, second_job.id], "accepted")
      expect(inquiries).to eq([first_inquiry])
    end
    it "returns 2 received accepted inquiry for specified job" do
      second_inquiry.status = "accepted"
      second_inquiry.save
      inquiries = Workflows::DashboardRenderer.new.received_inquiries_for([first_job.id, second_job.id], "accepted")
      expect(inquiries).to match_array([first_inquiry, second_inquiry])
    end
  end
  describe "sent_inquiries_for(user, status)" do
    it "returns 1 sent accepted inquiry for user" do
      first_inquiry.user = user
      first_inquiry.save
      second_inquiry.user = user
      second_inquiry.save
      inquiries = Workflows::DashboardRenderer.new.sent_inquiries_for(user, "accepted")
      expect(inquiries).to eq([first_inquiry])
    end
    it "returns 2 sent accepted inquiry for user" do
      first_inquiry.user = user
      first_inquiry.save
      second_inquiry.user = user
      second_inquiry.status = "accepted"
      second_inquiry.save
      inquiries = Workflows::DashboardRenderer.new.sent_inquiries_for(user, "accepted")
      expect(inquiries).to match_array([first_inquiry, second_inquiry])
    end
  end
  describe "display_by_order_of_relevance(ordered_options)" do
    it "returns the first set of options based on relevance order" do
      ordered_options = { first: ["1st", "set", "of", "options"], second: ["2nd", "set", "of", "options"], third: [] }
      relevant_option = Workflows::DashboardRenderer.new.display_by_order_of_relevance(ordered_options)
      expect(relevant_option).to eq(ordered_options[:first])
    end
    it "returns the third set of options based on relevance order" do
      ordered_options = { first: [], second: [], third: ["3rd", "set", "of", "options"] }
      relevant_option = Workflows::DashboardRenderer.new.display_by_order_of_relevance(ordered_options)
      expect(relevant_option).to eq(ordered_options[:third])
    end
  end
end
