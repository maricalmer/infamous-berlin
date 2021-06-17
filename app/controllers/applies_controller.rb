class AppliesController < ApplicationController
  def change_status
    @application = Apply.find(params[:id])
    if params[:status].present? && Apply.statuses.include?(params[:status])
      @application.update(status: params[:status])
    end
    redirect_to collaboration_path, notice: "Status updated to #{@application.status}"
  end
end
