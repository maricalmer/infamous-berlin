# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :html, :js #(-> login modal feature: session will start after login form submit via AJAX)
end
