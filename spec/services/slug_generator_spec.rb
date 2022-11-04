require 'rails_helper'
require "services/slug_generator"

RSpec.describe SlugGenerator do
  let(:first_user) { FactoryBot.create(:user) }
  let(:first_project) { FactoryBot.create(:project) }
  describe "assign_slug" do
    it "generates slug from user instance and username" do
      SlugGenerator.new(string: first_user.username, client: first_user).assign_slug
      expect(first_user.slug).to eq(first_user.username)
    end
    it "generates slug from project instance and title" do
      SlugGenerator.new(string: first_project.title, client: first_project).assign_slug
      expect(first_project.slug).to eq(first_project.title)
    end
    let(:second_user) { FactoryBot.build_stubbed(:user) }
    let(:second_project) { FactoryBot.build_stubbed(:project) }
    it "generates different slug from project instance and title if slug already exists" do
      SlugGenerator.new(string: first_project.title, client: first_project).assign_slug
      second_project.title = first_project.title
      SlugGenerator.new(string: second_project.title, client: second_project).assign_slug
      expect(second_project.slug).to_not eq(second_project.title.to_s)
      expect(second_project.slug).to eq("#{second_project.title}#{second_project.id}")
    end
    it "generates different slug from user instance and username if slug already exists" do
      SlugGenerator.new(string: first_user.username, client: first_user).assign_slug
      second_user.username = first_user.username
      SlugGenerator.new(string: second_user.username, client: second_user).assign_slug
      expect(second_user.slug).to_not eq(second_user.username.to_s)
      expect(second_user.slug).to eq("#{second_user.username}#{second_user.id}")
    end
  end
  describe "update_slug" do
    it "updates the slug if project gets updated" do
      first_project.title = "new_title"
      SlugGenerator.new(string: first_project.title, client: first_project).update_slug
      expect(first_project.slug).to eq("new_title")
    end
    it "updates the slug if user gets updated" do
      first_user.username = "new_username"
      SlugGenerator.new(string: first_user.username, client: first_user).update_slug
      expect(first_user.slug).to eq("new_username")
    end
  end
end
