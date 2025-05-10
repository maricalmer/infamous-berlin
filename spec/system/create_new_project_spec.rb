require 'rails_helper'

before do
  host! "http://#{Capybara.server_host}:#{Capybara.server_port}"
end

RSpec.describe "create a new project:" do
  let(:user) { FactoryBot.create(:user) }
  it "logs in, get to the project page and add member" do
    user.confirm
    visit(root_path)
    click_on("Sign Up")
    click_on("Log in")
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_on("Log in")
    visit(dashboard_path)
    click_on("Add a new project")
    fill_in("project_title", with: "Project title")
    fill_in("project_description", with: "Project description")
    page.attach_file("project_attachments", Rails.root / 'spec' / 'fixtures' / 'files' / 'img_sample.jpeg', make_visible: true)
    click_on("Save!")
    page.assert_selector('div', text: 'Project was successfully created')
  end
end
