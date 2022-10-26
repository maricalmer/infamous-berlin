require 'rails_helper'
require "services/slug_generator"

RSpec.describe SlugGenerator do
  let(:first_project) { FactoryBot.create(:project) }
  describe "assign_slug" do
    let(:user) { FactoryBot.build_stubbed(:user) }
    it "generates slug from object instance and string" do
      SlugGenerator.new(string: user.username, client: user).assign_slug
      expect(user.slug).to eq(user.username)
    end
    let(:second_project) { FactoryBot.build_stubbed(:project) }
    it "generates different slug from user instance and username" do
      SlugGenerator.new(string: first_project.title, client: first_project).assign_slug
      second_project.title = first_project.title
      SlugGenerator.new(string: second_project.title, client: second_project).assign_slug
      expect(second_project.slug).to_not eq(second_project.title.to_s)
      expect(second_project.slug).to eq("#{second_project.title}#{second_project.id}")
    end
  end
  describe "update_slug" do
    it "updates the slug if object gets updated" do
      first_project.title = "new_title"
      SlugGenerator.new(string: first_project.title, client: first_project).update_slug
      expect(first_project.slug).to eq("new_title")
    end
  end
end
