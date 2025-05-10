require 'rails_helper'

before do
  host! "http://#{Capybara.server_host}:#{Capybara.server_port}"
end

RSpec.describe "accept a job inquiry:" do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:job) { FactoryBot.create(:job, project: project) }
  let(:applicant) { FactoryBot.create(:user) }
  let(:inquiry) { FactoryBot.create(:inquiry, job: job, user: applicant) }
  it "logs in, get to the project page and add member" do
    user.confirm
    project
    job
    applicant.confirm
    inquiry
    visit(dashboard_path)
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_on("Log in")
    find_by_id("test-id-inquiries-menu").hover
    click_on("test-id-on-hold-inquiries-menu")
    click_on("test-id-on-hold-inquiry")
    click_on("Accept")
    page.assert_selector('span', text: 'accepted')
    page.assert_selector('div', text: 'Status updated to accepted')
  end
end
