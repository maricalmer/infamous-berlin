require 'rails_helper'

RSpec.describe MirrorRenderer do
  describe "load_mirrors_for_projects(status)" do
    let(:upcoming_project) { FactoryBot.create(:project, status: "upcoming") }
    let(:past_project) { FactoryBot.create(:project, status: "past") }
    let(:mirror) { FactoryBot.create(:mirror) }
    it "loads mirrors for past projects on 'past' status" do
      upcoming_project
      past_project
      mirrors = MirrorRenderer.new.load_mirrors_for_projects("past")
      expect(mirrors.count).to eq(1)
      expect(mirrors.first.project).to eq(past_project)
    end
    it "loads mirrors for upcoming projects on 'upcoming' status" do
      upcoming_project
      past_project
      mirrors = MirrorRenderer.new.load_mirrors_for_projects("upcoming")
      expect(mirrors.count).to eq(1)
      expect(mirrors.first.project).to eq(upcoming_project)
    end
  end
end
