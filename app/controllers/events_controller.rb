class EventsController < ApplicationController
  before_filter :require_user
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @event = Event.new
    if params[:commit] == 'all'
      search = Event.where(public_event: true)
      @events = (current_user.events + search).uniq
      for_calendar
    else
      @events = current_user.events
      for_calendar
    end
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)
    
    respond_to do |f|
      if @event.save
        f.html { redirect_to @event, flash[:info] = 'Event was successfully created.' }
        f.json { render action: 'show', status: :created, location: @event }
        f.js   { render action: 'show', status: :created, location: @event }
      else
        f.html { render action: 'new' }
        f.json { render json: @event.errors, status: :unprocessable_entity }
        f.js   { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event
      flash[:info] = 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url
    flash[:info] = 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:description, :published_on, :user_id, :public_event)
    end

    def for_calendar
      @events_by_date = @events.group_by(&:published_on)
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
    end
end
