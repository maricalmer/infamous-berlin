require 'rails_helper'

RSpec.describe Project do
  describe "validations" do
    let(:project) { FactoryBot.create(:project) }
    let(:project_no_title) { FactoryBot.build_stubbed(:project, title: nil) }
    let(:project_no_description) { FactoryBot.build_stubbed(:project, description: nil) }
    let(:project_no_attachment) { FactoryBot.build_stubbed(:project, attachments: nil) }
    it "is valid with title and description" do
      expect(project).to be_valid
    end
    it "is not valid without a title" do
      expect(project_no_title).to_not be_valid
    end
    it "is not valid without a description" do
      expect(project_no_description).to_not be_valid
    end
    it "is not valid without attachments" do
      expect(project_no_attachment).to_not be_valid
    end
    it "is not valid without a unique title" do
      second_project = Project.new(title: project.title,
                                   description: "description",
                                   attachments: [])
      expect(second_project).to_not be_valid
      expect(second_project.errors.full_messages_for(:title)).to include "Title has already been taken"
    end
    it "is not valid when slug is not unique" do
      second_project = Project.new(title: "title_second_project",
                                   description: "description",
                                   attachments: [])
      second_project.slug = project.slug
      expect(second_project).to_not be_valid
      expect(second_project.errors.full_messages_for(:slug)).to include "Slug has already been taken"
    end
    it "updates slug after title update" do
      project.title = "new_title"
      project.save
      expect(project.slug).to match("new_title")
    end
    it "creates a project mirror after project creation" do
      expect(project.mirrors.first.project_id).to eq(project.id)
    end
  end
end
