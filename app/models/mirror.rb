class Mirror < ApplicationRecord
  belongs_to :user
  belongs_to :project

  # require "workflows/mirror_renderer"

  def displays_cropped_img?
    displays_original_img? && cropped?
  end

  def displays_original_img?
    Workflows::MirrorRenderer.new.original_img?(self)
  end

  def displays_cropped_video_poster?
    displays_original_video_poster? && cropped?
  end

  def displays_original_video_poster?
    Workflows::MirrorRenderer.new.original_video_poster?(self)
  end

  def displays_cropped_audio_poster?
    displays_original_audio_poster? && cropped?
  end

  def attachment_key
    Workflows::MirrorRenderer.new.attachment_key_for(self)
  end

  private

  def cropped?
    Workflows::MirrorRenderer.new.cropped?(self)
  end

  def displays_original_audio_poster?
    Workflows::MirrorRenderer.new.original_audio_poster?(self)
  end
end
