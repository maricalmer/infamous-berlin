class Collab < ApplicationRecord
  belongs_to :project
  belongs_to :member, class_name: 'User', foreign_key: :user_id

  validate :project_member_not_project_owner
  validates :member, uniqueness: { scope: :project, message: "member is already part of the project" }

  after_create_commit :create_mirror
  after_destroy_commit :destroy_mirror

  private

  def project_member_not_project_owner
    return unless member == project.user

    errors.add(:member, 'is already collaborating on this project')
  end

  def create_mirror
    Mirror.create(user: member, project: project)
  end

  def destroy_mirror
    Mirror.where(user: member, project: project).first.destroy
  end
end
