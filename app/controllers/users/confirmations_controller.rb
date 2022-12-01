# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(_resource_name, resource)
    sign_in(resource)

    edit_user_path(resource.slug)
  end
end
