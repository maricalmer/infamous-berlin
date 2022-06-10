class Collab < ApplicationRecord
  belongs_to :project
  belongs_to :member, class_name: 'User', foreign_key: :user_id

  validate :project_member_not_project_owner

  after_create_commit :create_mirror
  after_destroy_commit :destroy_mirror

  private

  def project_member_not_project_owner
    return unless member == project.user

    errors.add(:member, 'You cannot be a member of your own project')
  end

  def create_mirror
    Mirror.create(user: member, project: project)
  end

  def destroy_mirror
    Mirror.where(user: member, project: project).first.destroy
  end
end
