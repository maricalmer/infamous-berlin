class MirrorPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def past_projects?
    true
  end

  def ongoing_projects?
    true
  end
end
