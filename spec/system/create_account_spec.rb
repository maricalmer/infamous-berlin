require 'rails_helper'

RSpec.describe "creating an account:", type: :system do
  before do
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end

  after(:each) do
    if Capybara.current_session.driver.respond_to?(:quit)
      Capybara.current_session.driver.quit
    end
  end

  it "can sign up" do
    visit(root_path)
    expect(page).to have_link("Sign Up")

    click_on("Sign Up")
    
    fill_in("user_username", with: "username")
    fill_in("user_email", with: "email@email.com")
    fill_in("user_password", with: "password")
    fill_in("user_password_confirmation", with: "password")
    
    click_on("Sign up")
    
    expect(current_path).to eq(confirmation_pending_path)
  end
end
