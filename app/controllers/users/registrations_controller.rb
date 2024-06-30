# frozen_string_literal: true

# class Users::RegistrationsController < Devise::RegistrationsController
#   # The path used after sign up for inactive accounts.
#   def after_inactive_sign_up_path_for(_resource)
#     confirmation_pending_path
#   end
# end

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
      flash.delete :recaptcha_error
      render :new
    end
  end
  def after_inactive_sign_up_path_for(_resource)
    confirmation_pending_path
  end
end
