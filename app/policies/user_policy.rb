class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.completed_profiles.includes([photo_attachment: :blob])
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
end
