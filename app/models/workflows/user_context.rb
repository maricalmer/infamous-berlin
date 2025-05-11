class Workflows::UserContext
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def contact_info?
    @user.website.present? ||
      @user.facebook.present? ||
      @user.instagram.present? ||
      @user.soundcloud.present? ||
      @user.youtube.present? ||
      @user.mixcloud.present? ||
      @user.linkedin.present? ||
      @user.twitter.present?
  end

  def unread_messages?
    Message.where(read_by_receiver: false).where.not(user: @user).where(chatroom: user_chatrooms).any?
  end

  def default_profile_pic?
    @user.photo.filename.to_s == 'default-profile-peep.png'
  end

  def add_default_img
    return if @user.photo.attached?

    @user.photo.attach(
      io: File.open(Rails.root.join("app", "assets", "images", "default-profile-peep.png")),
      filename: 'default-profile-peep.png',
      content_type: "image/png"
    )
  end

  def list_profiles
    list_legit_completed_profiles + list_fake_completed_profiles
  end

  def display_portfolio
    Project.where(id: past_projects_ids).or(Project.where(id: past_collabs_ids))
  end

  def display_ongoing_projects
    Project.where(id: upcoming_projects_ids).or(Project.where(id: upcoming_collabs_ids))
  end

  def find_collab_within(project_id)
    @user.collabs.find_by(project_id: project_id)
  end

  private

  def list_legit_completed_profiles
    User.where.not(bio: ["", nil]).where.not("email LIKE ?", "%" + "yopmail" + "%").includes(photo_attachment: :blob)
  end

  def list_fake_completed_profiles
    User.where("email LIKE ?", "%" + "yopmail" + "%")
  end

  def list_uncompleted_profiles
    User.where(bio: ["", nil]).includes(photo_attachment: :blob)
  end

  def user_chatrooms
    Chatroom.where(author_id: @user.id).or(Chatroom.where(receiver_id: @user.id))
  end

  def past_projects_ids
    Project.past.where(user: @user).pluck(:id)
  end

  def past_collabs_ids
    Collab.where(user_id: @user.id)
          .includes([:project]).select { |collab| collab.project.past? }
          .map(&:project_id)
  end

  def upcoming_projects_ids
    Project.upcoming.where(user: @user).pluck(:id)
  end

  def upcoming_collabs_ids
    Collab.where(user_id: @user.id)
          .select { |collab| collab.project.upcoming? }
          .map(&:project_id)
  end
end
