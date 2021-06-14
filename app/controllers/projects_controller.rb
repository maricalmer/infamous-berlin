class ProjectsController < ApplicationController

  private

  def article_params
    params.require(:project).permit(:title, :description, :category, :date, :location, :member, photos: [])
  end
end
