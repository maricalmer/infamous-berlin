# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :html, :js
end
