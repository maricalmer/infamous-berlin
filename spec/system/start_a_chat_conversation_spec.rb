require 'rails_helper'

RSpec.describe "send several messages to other user:", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  before do
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    user.confirm
    other_user.confirm
  end

  after(:each) do
    if Capybara.current_session.driver.respond_to?(:quit)
      Capybara.current_session.driver.quit
    end
  end

  it "logs in, sends multiple messages, and verifies message display" do
    visit(user_path(other_user.slug))
    click_on("Message #{other_user.username}")
    
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_on("Log in")
    
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Message #{other_user.username}")

    fill_in("message_content", with: "1st message")
    click_on("Send")
    
    click_on("Message #{other_user.username}")
    fill_in("message_content", with: "2nd message")
    click_on("Send")
    
    expect(page).to have_selector('div.message-container', count: 2)
    expect(page).to have_selector('div#message-1', text: "1st message")
    expect(page).to have_selector('div#message-2', text: "2nd message")
  end
end
