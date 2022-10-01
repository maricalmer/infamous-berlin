class ErrorPolicy < ApplicationPolicy
  def not_found?
    true
  end

  def internal_server?
    true
  end

  def unprocessable?
    true
  end

  def unacceptable?
    true
  end
end
