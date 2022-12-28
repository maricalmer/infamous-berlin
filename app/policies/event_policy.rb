class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      # scope.order('updated_at DESC')
    end
  end

  def show?
    true
  end

  def attend?
    true
  end

  def unattend?
    true
  end
end
