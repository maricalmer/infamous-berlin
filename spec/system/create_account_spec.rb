require 'rails_helper'

RSpec.describe "creating an account:" do
  before do
    host! "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
  it "can sign up" do
    visit(root_path)
    click_on("Sign Up")
    fill_in("user_username", with: "username")
    fill_in("user_email", with: "email@email.com")
    fill_in("user_password", with: "password")
    fill_in("user_password_confirmation", with: "password")
    click_on("Sign up")
    expect(current_path).to eq(confirmation_pending_path)
  end
end
