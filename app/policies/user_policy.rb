class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.list_user_index
    end
  end

  def show?
    true
  end

  def update?
    record == user
  end

  def destroy?
    record == user
  end

  def after_registration_path?
    true
  end
end
