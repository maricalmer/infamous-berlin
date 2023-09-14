# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # login modal feature: session will start after login form submit via AJAX
  respond_to :html, :js
end
