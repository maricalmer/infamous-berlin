require 'rails_helper'

RSpec.describe ProjectSelector do
  describe "custom_index" do
    let(:upcoming_project) { FactoryBot.create(:project, status: "upcoming") }
    let(:past_project) { FactoryBot.create(:project, status: "past") }
    it "defaults to list upcoming projects" do
      upcoming_project
      past_project
      params = { search: nil }
      projects = ProjectSelector.new.custom_index(params)
      expect(projects).to eq([upcoming_project])
    end
    it "lists only past projects if search filtered on past project status" do
      upcoming_project
      past_project
      params = { search: { status: "past" } }
      projects = ProjectSelector.new.custom_index(params)
      expect(projects).to eq([past_project])
    end
    it "lists no past project if search filtered on past project status" do
      upcoming_project
      params = { search: { status: "past" } }
      projects = ProjectSelector.new.custom_index(params)
      expect(projects.count).to eq(0)
    end
    it "lists only upcoming projects if search filtered on upcoming status" do
      upcoming_project
      past_project
      params = { search: { status: "upcoming" } }
      projects = ProjectSelector.new.custom_index(params)
      expect(projects).to eq([upcoming_project])
    end
    it "lists no upcoming project if search filtered on upcoming project status" do
      past_project
      params = { search: { status: "upcoming" } }
      projects = ProjectSelector.new.custom_index(params)
      expect(projects.count).to eq(0)
    end
    it "lists all projects if search filtered on all status" do
      upcoming_project
      past_project
      params = { search: { status: "all" } }
      projects = ProjectSelector.new.custom_index(params)
      expect(projects).to match_array([upcoming_project, past_project])
    end
  end
end
