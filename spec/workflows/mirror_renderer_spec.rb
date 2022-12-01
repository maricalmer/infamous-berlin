require 'rails_helper'

require "workflows/mirror_renderer"

RSpec.describe MirrorRenderer do
  describe "load_mirrors_for_projects(status)" do
    let(:user) { FactoryBot.create(:user) }
    let(:upcoming_project) { FactoryBot.create(:project, status: "upcoming", user: user) }
    let(:past_project) { FactoryBot.create(:project, status: "past", user: user) }
    before(:example) do
      upcoming_project
      past_project
    end
    it "loads mirrors for past projects on 'past' status" do
      mirrors = MirrorRenderer.new(user).load_mirrors_for_projects("past")
      expect(mirrors.first.project).to eq(past_project)
    end
    it "loads mirrors for upcoming projects on 'upcoming' status" do
      mirrors = MirrorRenderer.new(user).load_mirrors_for_projects("upcoming")
      expect(mirrors.first.project).to eq(upcoming_project)
    end
  end
  describe "attachment_key_for(mirror)" do
    let(:project) { FactoryBot.create(:project) }
    it "returns the right key" do
      project_attachment_key = project.attachments.first.key
      mirrors = Mirror.all
      mirror_in_db_key = MirrorRenderer.new.attachment_key_for(mirrors.first)
      expect(mirror_in_db_key).to eq(project_attachment_key)
    end
  end
  describe "original_img?(mirror)" do
    let(:img_attachment_project) { FactoryBot.create(:project) }
    let(:audio_attachment_project) { FactoryBot.create(:project) }
    it "it validates that the first attachment is an img" do
      img_attachment_project
      mirrors = Mirror.all
      img_check = MirrorRenderer.new.original_img?(mirrors.first)
      expect(mirrors.count).to eq(1)
      expect(img_check).to be_truthy
    end
    it "it validates that the first attachment is not an img" do
      audio_attachment_project.attachments.purge
      audio_attachment_project.attachments.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "audio_sample.mp3")),
        filename: 'audio_sample.mp3',
        content_type: "audio/mpeg"
      )
      mirrors = Mirror.all
      img_check = MirrorRenderer.new.original_img?(mirrors.first)
      expect(mirrors.count).to eq(1)
      expect(img_check).to be_falsy
    end
  end
  describe "original_video_poster?(mirror)" do
    let(:img_attachment_project) { FactoryBot.create(:project) }
    let(:video_attachment_project) { FactoryBot.create(:project) }
    it "it validates that the first attachment is a video poster" do
      video_attachment_project.attachments.purge
      video_attachment_project.attachments.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "video_sample.mp4")),
        filename: 'video_sample.mp4',
        content_type: "video/mp4"
      )
      Project.all.count
      mirrors = Mirror.all
      video_poster_check = MirrorRenderer.new.original_video_poster?(mirrors.first)
      expect(mirrors.count).to eq(1)
      expect(video_poster_check).to be_truthy
    end
    it "it validates that the first attachment is not a video poster" do
      img_attachment_project
      mirrors = Mirror.all
      video_poster_check = MirrorRenderer.new.original_video_poster?(mirrors.first)
      expect(mirrors.count).to eq(1)
      expect(video_poster_check).to be_falsy
    end
  end
  describe "original_audio_poster?(mirror)" do
    let(:img_attachment_project) { FactoryBot.create(:project) }
    let(:audio_attachment_project) { FactoryBot.create(:project) }
    it "it validates that the first attachment is an audio poster" do
      audio_attachment_project.attachments.purge
      audio_attachment_project.attachments.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "audio_sample.mp3")),
        filename: 'audio_sample.mp3',
        content_type: "audio/mpeg"
      )
      mirrors = Mirror.all
      audio_poster_check = MirrorRenderer.new.original_audio_poster?(mirrors.first)
      expect(mirrors.count).to eq(1)
      expect(audio_poster_check).to be_truthy
    end
    it "it validates that the first attachment is not an audio poster" do
      img_attachment_project
      mirrors = Mirror.all
      audio_poster_check = MirrorRenderer.new.original_video_poster?(mirrors.first)
      expect(mirrors.count).to eq(1)
      expect(audio_poster_check).to be_falsy
    end
  end
  describe "cropped?(mirror)" do
    let(:img_attachment_project) { FactoryBot.create(:project) }
    before(:example) do
      img_attachment_project
    end
    it "it validates that a mirror cover got cropped" do
      mirrors = Mirror.all
      mirrors.first.update(crop_x: 300, crop_y: 20, crop_h: 1200, crop_w: 650)
      img_crop_check = MirrorRenderer.new.cropped?(mirrors.first)
      expect(mirrors.count).to eq(1)
      expect(img_crop_check).to be_truthy
    end
    it "it validates that a mirror cover did not get cropped" do
      mirrors = Mirror.all
      img_crop_check = MirrorRenderer.new.cropped?(mirrors.first)
      expect(mirrors.count).to eq(1)
      expect(img_crop_check).to be_falsy
    end
  end
end
