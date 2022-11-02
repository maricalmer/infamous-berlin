require 'rails_helper'

RSpec.describe "send several messages to other user:" do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  it "logs in, get to the project page and add member" do
    user.confirm
    other_user.confirm
    visit(user_path(other_user.slug))
    click_on("Message #{other_user.username}")
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_on("Log in")
    click_on("Message #{other_user.username}")
    fill_in("message_content", with: "1st message")
    click_on("Send")
    click_on("Message #{other_user.username}")
    fill_in("message_content", with: "2nd message")
    click_on("Send")
    page.assert_selector('div.message-container', count: 2)
    page.assert_selector('div#message-1', text: "1st message")
    page.assert_selector('div#message-2', text: "2nd message")
  end
end
