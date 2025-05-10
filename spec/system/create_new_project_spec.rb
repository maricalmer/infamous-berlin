require 'rails_helper'

RSpec.describe "create a new project:", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    user.confirm
  end

  after(:each) do
    if Capybara.current_session.driver.respond_to?(:quit)
      Capybara.current_session.driver.quit
    end
  end

  it "logs in, gets to the project page, and adds a new project" do
    visit(root_path)
    expect(page).to have_link("Log in")
    
    click_on("Log in")
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_on("Log in")
    
    expect(page).to have_content('Signed in successfully')
    
    visit(dashboard_path)
    click_on("Add a new project")
    
    fill_in("project_title", with: "Project title")
    fill_in("project_description", with: "Project description")

    page.attach_file("project_attachments", Rails.root / 'spec' / 'fixtures' / 'files' / 'img_sample.jpeg', make_visible: true)
    
    click_on("Save!")
    
    expect(page).to have_selector('div', text: 'Project was successfully created')
  end
end
