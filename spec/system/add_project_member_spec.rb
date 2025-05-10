require 'rails_helper'

RSpec.describe "adding a new project member", type: :system do
  before do
    host! "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:member) { FactoryBot.create(:user) }

  before do
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    user.confirm
    member.confirm
  end

  it "logs in, gets to the project page and adds member" do
    visit root_path
    expect(page).to have_content('Log in')
    
    click_on 'Log in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    
    expect(page).to have_content('Signed in successfully')

    visit project_path(project.slug)
    expect(page).to have_content(project.title)
    
    find('#add-member-btn', wait: 10).click
    fill_in 'project_member', with: member.username
    click_button '+'
    
    expect(page).to have_current_path(project_path(project.slug))
    expect(page).to have_content("Member: #{member.username}")
    expect(project.reload.members).to include(member)
  end
end
