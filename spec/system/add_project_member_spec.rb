require 'rails_helper'

RSpec.describe "adding a new project member", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:member) { FactoryBot.create(:user) }

  # Set up Capybara with Selenium before running any test
  before do
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    user.confirm
    member.confirm
  end

  # Cleanup WebDriver after each test to prevent zombie processes
  after(:each) do
    if Capybara.current_session.driver.respond_to?(:quit)
      Capybara.current_session.driver.quit
    end
  end

  it "logs in, gets to the project page and adds member" do
    # Ensure we're on the root page and login link is present
    visit root_path
    expect(page).to have_content('Log in')

    click_on 'Log in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')

    # Navigate to the project page
    visit project_path(project.slug)
    expect(page).to have_content(project.title)

    # Wait for the 'Add Member' button and click it
    find('#add-member-btn', wait: 10).click

    # Fill in the member's username and add them
    fill_in 'project_member', with: member.username
    click_button '+'

    # Ensure we're still on the project page and verify the member is added
    expect(page).to have_current_path(project_path(project.slug))
    expect(page).to have_content("Member: #{member.username}")
    expect(project.reload.members).to include(member)
  end
end
