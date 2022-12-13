class Workflows::MirrorRenderer
  attr_reader :user

  def initialize(user = nil)
    @user = user
  end

  def load_mirrors_for_projects(status)
    mirrors = select_mirrors(status)
    position(mirrors)
    return mirrors
  end

  def attachment_key_for(mirror)
    mirror.project.attachments.first.key
  end

  def original_img?(mirror)
    mirror.project.attachments.first.image?
  end

  def original_video_poster?(mirror)
    mirror.project.attachments.first.video?
  end

  def original_audio_poster?(mirror)
    mirror.project.attachments.first.audio?
  end

  def cropped?(mirror)
    mirror.crop_x.present?
  end

  private

  def select_mirrors(status)
    all_projects_ids = Project.public_send(status)
                              .where(user: @user)
                              .or(Project.public_send(status)
                              .where(id: project_ids_from_collabs))
    Mirror.where(project_id: all_projects_ids)
          .where(user: @user)
          .order(:created_at)
          .includes(%i[user project])
  end

  def project_ids_from_collabs
    Collab.where(user_id: @user.id).pluck(:project_id)
  end

  def position(mirrors)
    i = 1
    mirrors.each do |mirror|
      mirror.update(default_position: i)
      default_grid_position(i, mirror) if no_positioning?(mirror)
      i += 1
    end
  end

  def default_grid_position(index, mirror)
    factor = pull_factor(index)
    fraction = index / 12
    case factor
    when 0 then mirror.update(grid_x: "8", grid_y: ((fraction - 1) * 12 + 10).to_s, grid_w: "4", grid_h: "2")
    when 1 then mirror.update(grid_x: "0", grid_y: (fraction * 12).to_s, grid_w: "4", grid_h: "4")
    when 2 then mirror.update(grid_x: "4", grid_y: (fraction * 12).to_s, grid_w: "3", grid_h: "6")
    when 3 then mirror.update(grid_x: "7", grid_y: (fraction * 12).to_s, grid_w: "2", grid_h: "4")
    when 4 then mirror.update(grid_x: "9", grid_y: (fraction * 12).to_s, grid_w: "3", grid_h: "4")
    when 5 then mirror.update(grid_x: "0", grid_y: (fraction * 12 + 4).to_s, grid_w: "4", grid_h: "2")
    when 6 then mirror.update(grid_x: "7", grid_y: (fraction * 12 + 4).to_s, grid_w: "5", grid_h: "2")
    when 7 then mirror.update(grid_x: "0", grid_y: (fraction * 12 + 6).to_s, grid_w: "3", grid_h: "4")
    when 8 then mirror.update(grid_x: "3", grid_y: (fraction * 12 + 6).to_s, grid_w: "2", grid_h: "4")
    when 9 then mirror.update(grid_x: "5", grid_y: (fraction * 12 + 6).to_s, grid_w: "3", grid_h: "6")
    when 10 then mirror.update(grid_x: "8", grid_y: (fraction * 12 + 6).to_s, grid_w: "4", grid_h: "4")
    when 11 then mirror.update(grid_x: "0", grid_y: (fraction * 12 + 10).to_s, grid_w: "5", grid_h: "2")
    end
  end

  def no_positioning?(mirror)
    mirror.grid_x.nil?
  end

  def pull_factor(index)
    float = index / 12.0
    decimals = BigDecimal(float.to_s).modulo(1).to_f
    return (decimals / 0.0833333333333335).round
  end
end
