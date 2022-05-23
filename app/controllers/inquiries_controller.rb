class InquiriesController < ApplicationController
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy, :change_status]
  before_action :set_job, only: [:new, :create]

  def index
    @inquiries = Inquiry.all
  end

  def show
    @statuses = Inquiry.statuses.keys
  end

  def new
    @inquiry = @job.inquiries.build
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.job = @job
    @inquiry.user = current_user
    if @inquiry.save
      redirect_to job_path(@job), notice: 'Your application was successfully sent.'
    else
      render :new
    end
  end

  def edit
    @job = @inquiry.job
  end

  def update
    @inquiry.update(inquiry_params)
    redirect_to inquiry_path(@inquiry)
  end

  def destroy
    @inquiry.destroy
    redirect_to dashboard_path, notice: 'Application was successfully deleted.'
  end

  def change_status
    if params[:status].present? && Inquiry.statuses.include?(params[:status])
      @inquiry.update(status: params[:status])
    end
    redirect_to @inquiry, notice: "Status updated to #{@inquiry.status}"
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def set_job
    @job = Job.find(params[:job_id])
  end

  def inquiry_params
    params.require(:inquiry).permit(:motivation, :experience, :attached_file)
  end
end
