class Mirror < ApplicationRecord
  belongs_to :portfolio
  belongs_to :project

  def set_img
    project.attachments.any? ? update_img(project.attachments.first.key) : update_img("logo.png")
    # ^^ add default value in migration
  end

  def update_img(key)
    Mirror.update(img_url: key)
  end

  def set_position
    portfolio.mirrors
  end
end
