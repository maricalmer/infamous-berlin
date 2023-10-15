class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :find_event, only: %i[show attend unattend]

  def show
  end

  def index
    # list all events
    @events = policy_scope(Event)
    # create calendar of events covering the next 30 days
    @calendar = Event.create_calendar
    @recommended_events = Event.where("recommended = ? AND date > ?", true, 1.hours.ago).includes(photo_attachment: :blob)
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    authorize @event
  end

  def edit
  end

  def update
    @event.update(event_params)
  end

  def attend
    @event.attend(current_user.id)
    @event.save
    respond_to do |format|
      format.html { redirect_to event_path }
      format.js
    end
  end

  def unattend
    @event.unattend(current_user.id)
    @event.save
    respond_to do |format|
      format.html { redirect_to event_path }
      format.js { render action: :attend }
    end
  end

  private

  def find_event
    @event = Event.find_by!(slug: params[:slug])
    authorize @event
  end

  def event_params
    params.require(:project).permit(:title, :venue, :address, :date, :organizer, :genre, :attendees, :description, :media, :photo)
  end
end
