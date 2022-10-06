require 'rails_helper'

RSpec.describe User do
  let(:user) { FactoryBot.create(:user) }
  let(:user_no_email) { FactoryBot.build_stubbed(:user, email: nil) }
  let(:user_no_email_domain) { FactoryBot.build_stubbed(:user, email: "email@") }
  let(:user_no_email_local) { FactoryBot.build_stubbed(:user, email: "@email.com") }
  let(:user_no_password) { FactoryBot.build_stubbed(:user, password: "") }
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

RSpec.describe "contact_info?" do
  let(:user_no_contact_info) { FactoryBot.build_stubbed(:user) }
  let(:user_with_website) { FactoryBot.build_stubbed(:user, website: "website.com") }
  let(:user_with_instagram) { FactoryBot.build_stubbed(:user, instagram: "my_instagram.com") }
  let(:user_with_twitter) { FactoryBot.build_stubbed(:user, twitter: "my_twitter.com") }
  it "is falsy when empty" do
    expect(user_no_contact_info.contact_info?).to be_falsy
  end
  it "is truthy when website field is present" do
    expect(user_with_website.contact_info?).to be_truthy
  end
  it "is truthy when instagram field is present" do
    expect(user_with_instagram.contact_info?).to be_truthy
  end
  it "is truthy when twitter field is present" do
    expect(user_with_twitter.contact_info?).to be_truthy
  end
end

RSpec.describe "unread_messages?" do
  let(:author) { FactoryBot.create(:user) }
  let(:receiver) { FactoryBot.create(:user) }
  let(:chatroom) { FactoryBot.create(:chatroom, author: author, receiver: receiver) }
  let(:message) { FactoryBot.create(:message, chatroom: chatroom, user: author) }
  it "is truthy when message not read by receiver" do
    message
    expect(receiver.unread_messages?).to be_truthy
  end
  it "is falsy when message read by receiver" do
    message.read_by_receiver = true
    message.save
    expect(receiver.unread_messages?).to be_falsy
  end
end

RSpec.describe "default_profile_pic?" do
  let(:user) { FactoryBot.create(:user) }
  it "is truthy when no profile pic uploaded" do
    expect(user.default_profile_pic?).to be_truthy
  end
  it "is falsy when profile pic uploaded" do
    user.photo.attach(
      io: File.open(Rails.root.join("app", "assets", "images", "logo.png")),
      filename: 'logo.png',
      content_type: "image/png"
    )
    expect(user.default_profile_pic?).to be_falsy
  end
end

RSpec.describe "completed_profiles" do
  let(:user) { FactoryBot.create(:user) }
  it "is truthy when no profile pic uploaded" do
    expect(user.default_profile_pic?).to be_truthy
  end
  it "is falsy when profile pic uploaded" do
    user.photo.attach(
      io: File.open(Rails.root.join("app", "assets", "images", "logo.png")),
      filename: 'logo.png',
      content_type: "image/png"
    )
    expect(user.default_profile_pic?).to be_falsy
  end
end
