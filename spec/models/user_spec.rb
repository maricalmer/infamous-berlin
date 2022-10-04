require 'rails_helper'

RSpec.describe User do
  let(:user) { FactoryBot.create(:user) }
  let(:user_no_email) { FactoryBot.build_stubbed(:user, email: nil) }
  let(:user_no_email_domain) { FactoryBot.build_stubbed(:user, email: "email@") }
  let(:user_no_email_local) { FactoryBot.build_stubbed(:user, email: "@email.com") }
  let(:user_no_password) { FactoryBot.build_stubbed(:user, password: nil) }
  let(:user_short_password) { FactoryBot.build_stubbed(:user, password: "123") }
  let(:user_no_username) { FactoryBot.build_stubbed(:user, username: nil) }
  it "is valid with valid attributes" do
    expect(user).to be_valid
  end
  it "is not valid without an email" do
    expect(user_no_email).to_not be_valid
  end
  it "is not valid without an email domain" do
    expect(user_no_email_domain).to_not be_valid
  end
  it "is not valid without an email local" do
    expect(user_no_email_local).to_not be_valid
  end
  it "is not valid without a password" do
    expect(user_no_password).to_not be_valid
  end
  it "is not valid if password is less than 6 characters" do
    expect(user_short_password).to_not be_valid
  end
  it "is not valid without a username" do
    expect(user_no_username).to_not be_valid
  end
  it "is not valid without a unique username" do
    second_user = User.new(email: "second_user_email@email.com",
                           password: "password",
                           username: user.username.upcase)
    expect(second_user).to_not be_valid
    expect(second_user.errors.full_messages_for(:username)).to include "Username has already been taken"
  end
  it "is not valid when slug is not unique" do
    second_user = User.new(email: "second_user_email@email.com",
                           password: "password",
                           username: "second_user_username")
    second_user.slug = user.slug
    expect(second_user).to_not be_valid
    expect(second_user.errors.full_messages_for(:slug)).to include "Slug has already been taken"
  end
end
