class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.order('created_at DESC')
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.project.user == user
  end

  def destroy?
    record.project.user == user
  end
end
