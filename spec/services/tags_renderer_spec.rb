require 'rails_helper'

RSpec.describe Services::TagsRenderer do
  let(:user) { FactoryBot.create(:user) }
  describe "format_tags" do
    let(:single_category_project) { FactoryBot.build_stubbed(:project, category: "category_1") }
    let(:multi_categories_project) { FactoryBot.build_stubbed(:project, category: "category1 category2") }
    let(:multi_categories_project_underscore) { FactoryBot.build_stubbed(:project, category: "category_1 category_2") }
    let(:multi_categories_project_trimming) { FactoryBot.build_stubbed(:project, category: "  category_1   category_2  ") }
    it "returns formatted tags set for one category project" do
      tags = Services::TagsRenderer.new(single_category_project.category).format_tags
      expect(tags).to eq(["category 1"])
    end
    it "returns formatted tags set for multi categories project" do
      tags = Services::TagsRenderer.new(multi_categories_project.category).format_tags
      expect(tags).to eq(["category1", "category2"])
    end
    it "returns formatted tags set for multi categories project with spaces trimmed" do
      tags = Services::TagsRenderer.new(multi_categories_project_trimming.category).format_tags
      expect(tags).to eq(["category 1", "category 2"])
    end
    let(:multi_skills_user) { FactoryBot.build_stubbed(:user, skills: "  skill_1   skill_2  ") }
    it "returns formatted tags set for multi skills user" do
      tags = Services::TagsRenderer.new(multi_skills_user.skills).format_tags
      expect(tags).to eq(["skill 1", "skill 2"])
    end
    let(:job_requiring_skills) { FactoryBot.build_stubbed(:job, skills_needed: "  skill_1   skill_2  ") }
    it "returns formatted tags set for job required skills" do
      tags = Services::TagsRenderer.new(job_requiring_skills.skills_needed).format_tags
      expect(tags).to eq(["skill 1", "skill 2"])
    end
  end
end
