require 'rails_helper'
require 'support/headless'

RSpec.describe "adding a new project member:" do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:member) { FactoryBot.create(:user) }
  it "logs in, get to the project page and add member" do
    user.confirm
    visit(root_path)
    click_on("Sign Up")
    click_on("Log in")
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_on("Log in")
    visit(project_path(project.slug))
    click_on("Add member")
    fill_in("project_member", with: member.username)
    click_on("+")
    expect(current_path).to eq(project_path(project.slug))
    page.assert_selector('div', text: 'Member:')
    expect(project.members.first).to eq(member)
  end
end
