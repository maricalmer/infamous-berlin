require 'rails_helper'

RSpec.describe "create a new project:", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    user.confirm
  end

  # Cleanup WebDriver after each test to prevent zombie processes
  after(:each) do
    if Capybara.current_session.driver.respond_to?(:quit)
      Capybara.current_session.driver.quit
    end
  end

  it "logs in, gets to the project page, and adds a new project" do
    # Visit the root path and check if the Sign Up and Log In options are available
    visit(root_path)
    expect(page).to have_link("Log in")
    
    # Click on the 'Log in' link and log the user in
    click_on("Log in")
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_on("Log in")
    
    # Ensure the user is logged in and redirected to the dashboard
    expect(page).to have_content('Signed in successfully')
    
    # Navigate to the dashboard and click on "Add a new project"
    visit(dashboard_path)
    click_on("Add a new project")
    
    # Fill in the project details
    fill_in("project_title", with: "Project title")
    fill_in("project_description", with: "Project description")
    
    # Attach the project image file (using the correct path for the file)
    page.attach_file("project_attachments", Rails.root / 'spec' / 'fixtures' / 'files' / 'img_sample.jpeg', make_visible: true)
    
    # Save the project and ensure the success message is displayed
    click_on("Save!")
    
    # Check if the success message is shown on the page
    expect(page).to have_selector('div', text: 'Project was successfully created')
  end
end
