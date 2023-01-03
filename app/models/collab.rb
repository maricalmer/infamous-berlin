class Collab < ApplicationRecord
  belongs_to :project
  belongs_to :member, class_name: 'User', foreign_key: :user_id

  validate :project_member_not_project_owner
  validates :member, uniqueness: { scope: :project, message: "member is already part of the project" }

  after_create_commit :create_mirror

  private

  def project_member_not_project_owner
    return unless member == project.user

    errors.add(:member, 'and Project Owner cannot be the same user')
  end

  def create_mirror
    Mirror.create(user: member, project: project)
  end
end
