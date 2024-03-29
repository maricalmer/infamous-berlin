require 'rails_helper'

RSpec.describe User do
  describe "validations" do
    let(:user) { FactoryBot.create(:user) }
    let(:user_nil_email) { FactoryBot.build_stubbed(:user, email: nil) }
    let(:user_empty_string_email) { FactoryBot.build_stubbed(:user, email: "") }
    let(:user_no_email_domain) { FactoryBot.build_stubbed(:user, email: "email@") }
    let(:user_no_email_local) { FactoryBot.build_stubbed(:user, email: "@email.com") }
    let(:user_empty_string_password) { FactoryBot.build_stubbed(:user, password: "") }
    let(:user_short_password) { FactoryBot.build_stubbed(:user, password: "123") }
    let(:user_nil_username) { FactoryBot.build_stubbed(:user, username: nil) }
    let(:user_empty_string_username) { FactoryBot.build_stubbed(:user, username: "") }
    let(:user_too_long_username) { FactoryBot.build_stubbed(:user, username: 'a' * 101) }
    let(:user_special_character_username) { FactoryBot.build_stubbed(:user, username: "<") }
    let(:user_special_character_bio) { FactoryBot.build_stubbed(:user, bio: "<") }
    it "is valid with username, email and password" do
      expect(user).to be_valid
    end
    it "is not valid if email is nil" do
      expect(user_nil_email).to_not be_valid
    end
    it "is not valid if email is empty string" do
      expect(user_nil_email).to_not be_valid
    end
    it "is not valid without an email domain" do
      expect(user_no_email_domain).to_not be_valid
    end
    it "is not valid without an email local" do
      expect(user_no_email_local).to_not be_valid
    end
    it "is not valid without a password" do
      expect(user_empty_string_password).to_not be_valid
    end
    it "is not valid if password is less than 6 characters" do
      expect(user_short_password).to_not be_valid
    end
    it "is not valid with a nil username" do
      expect(user_nil_username).to_not be_valid
    end
    it "is not valid with an empty string username" do
      expect(user_empty_string_username).to_not be_valid
    end
    it "is not valid with a username over 100 characters" do
      expect(user_too_long_username).to_not be_valid
    end
    it "is not valid with a special character in username" do
      expect(user_special_character_username).to_not be_valid
    end
    it "is not valid with a special character in bio" do
      expect(user_special_character_bio).to_not be_valid
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
  describe "callbacks" do
    let(:user) { FactoryBot.create(:user) }
    it "updates slug after username update" do
      user.username = "new_username"
      user.save
      expect(user.slug).to match("new_username")
    end
  end
end
