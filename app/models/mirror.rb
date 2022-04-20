class Mirror < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def set_img
    project.attachments.any? ? update_img(project.attachments.first.key) : update_img("logo.png")
    # ^^ add default value in migration
  end

  def update_img(key)
    Mirror.update(img_key: key)
  end

  def default_grid_position(index)
    case index
    when 0 then update(grid_x: "0", grid_y: "0", grid_w: "4", grid_h: "4")
    when 1 then update(grid_x: "4", grid_y: "0", grid_w: "3", grid_h: "6")
    when 2 then update(grid_x: "7", grid_y: "0", grid_w: "2", grid_h: "4")
    when 3 then update(grid_x: "9", grid_y: "0", grid_w: "3", grid_h: "4")
    when 4 then update(grid_x: "0", grid_y: "4", grid_w: "4", grid_h: "2")
    when 5 then update(grid_x: "7", grid_y: "4", grid_w: "5", grid_h: "2")
    when 6 then update(grid_x: "0", grid_y: "6", grid_w: "3", grid_h: "4")
    when 7 then update(grid_x: "3", grid_y: "6", grid_w: "2", grid_h: "4")
    when 8 then update(grid_x: "5", grid_y: "6", grid_w: "3", grid_h: "6")
    when 9 then update(grid_x: "8", grid_y: "6", grid_w: "4", grid_h: "4")
    when 10 then update(grid_x: "0", grid_y: "10", grid_w: "5", grid_h: "2")
    when 11 then update(grid_x: "8", grid_y: "10", grid_w: "4", grid_h: "2")
    end
  end
end
