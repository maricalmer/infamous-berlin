class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_event, only: %i[show]

  def show
  end

  def index
    @events = policy_scope(Event)
  end

  private

  def set_event
    @event = Event.find_by!(slug: params[:slug])
    authorize @event
  end

  def event_params
    params.require(:project).permit(:title, :venue, :address, :date, :organizer, :genre, :attendees, :description, :media, :photo)
  end
end
