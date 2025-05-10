require 'rails_helper'

RSpec.describe "send several messages to other user:", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  before do
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    user.confirm
    other_user.confirm
  end

  # Cleanup WebDriver after each test to prevent zombie processes
  after(:each) do
    if Capybara.current_session.driver.respond_to?(:quit)
      Capybara.current_session.driver.quit
    end
  end

  it "logs in, sends multiple messages, and verifies message display" do
    # Visit the other user's profile page and click on the message button
    visit(user_path(other_user.slug))
    click_on("Message #{other_user.username}")
    
    # Log in with the user's credentials
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_on("Log in")
    
    # Ensure the user is logged in and redirected to the messages page
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Message #{other_user.username}")

    # Send the first message
    fill_in("message_content", with: "1st message")
    click_on("Send")
    
    # Send the second message
    click_on("Message #{other_user.username}")
    fill_in("message_content", with: "2nd message")
    click_on("Send")
    
    # Verify that both messages are displayed
    expect(page).to have_selector('div.message-container', count: 2)
    expect(page).to have_selector('div#message-1', text: "1st message")
    expect(page).to have_selector('div#message-2', text: "2nd message")
  end
end
