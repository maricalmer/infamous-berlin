class CollabPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    true
  end

  def destroy?
    record.project.user == user || record.user_id == user.id
  end
end
