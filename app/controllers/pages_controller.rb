class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @users = User.all.sort_by { |user| user.id }
    @projects = Project.all.sort_by { |project| project.id }
  end

  def messages
  end
end
