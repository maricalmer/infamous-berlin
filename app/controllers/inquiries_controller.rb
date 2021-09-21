class InquiriesController < ApplicationController
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]
  before_action :set_job, only: [:show, :new, :create]

  def index
    @inquiries = Inquiry.all
  end

  def show
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
  end

  def update
    @inquiry.update(inquiry_params)
    redirect_to inquiry_path(@inquiry)
  end

  def destroy
    @inquiry.deleted!
    redirect_to dashboard_path, notice: 'Application was successfully deleted.'
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def set_job
    @job = Job.find(params[:job_id])
  end

  def inquiry_params
    params.require(:inquiry).permit(:text)
  end

  def change_status
    @inquiry = Inquiry.find(params[:id])
    if params[:status].present? && Inquiry.statuses.include?(params[:status])
      @inquiry.update(status: params[:status])
    end
    redirect_to jobs_path, notice: "Status updated to #{@inquiry.status}"
  end
end
