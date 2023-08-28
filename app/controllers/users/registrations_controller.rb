# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(_resource)
    confirmation_pending_path
  end
end
