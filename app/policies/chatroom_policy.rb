class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.participating(user).order('updated_at DESC')
    end
  end

  def show?
    record.author == user || record.receiver == user
  end

  def create?
    true
  end
end
