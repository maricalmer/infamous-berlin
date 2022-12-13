require 'rails_helper'

RSpec.describe Collab do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project) }
  let(:collab) { FactoryBot.create(:collab, member: user, project: project) }
  describe "validations" do
    let(:duplicate_collab) { FactoryBot.build_stubbed(:collab) }
    let(:second_user) { FactoryBot.build_stubbed(:user) }
    it "is valid with project and member" do
      expect(collab).to be_valid
    end
    it "is unvalid with identical project owner and member" do
      collab.project.user = user
      expect(collab).to_not be_valid
      expect(collab.errors.full_messages_for(:member)).to include "Member is already collaborating on this project"
    end
    it "is valid with distinct project owner and member" do
      collab.project.user = second_user
      expect(collab).to be_valid
    end
    it "cannot be created if another collab including same project and same member already exists" do
      collab
      duplicate_collab.project = project
      duplicate_collab.member = user
      expect(duplicate_collab).to_not be_valid
    end
  end
  describe "callbacks" do
    it "creates a mirror object after collab creation" do
      user
      project
      collab
      mirrors = Mirror.all
      expect(mirrors.count).to eq(2)
      expect(mirrors.first.project).to eq(project)
      expect(mirrors.first.user).to eq(project.user)
      expect(mirrors.last.project).to eq(project)
      expect(mirrors.last.user).to eq(user)
    end
    it "deletes a mirror object after collab destroy" do
      collab.destroy
      mirrors = Mirror.all
      expect(mirrors.count).to eq(1)
      expect(mirrors.last.project).to eq(project)
      expect(mirrors.last.user).to_not eq(user)
      expect(mirrors.last.user).to eq(project.user)
    end
  end
end
