class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in, only: [:edit, :update, :destroy, :new, :create, :remove_all]

  # GET /events
  # GET /events.json

  # fake_state = Venue.where(remote_id: 298929)
  # fake_haunt = Venue.where(remote_id: 298932)
  # fake_state_events = Event.where(venue_id: fake_state)
  # fake_haunt_events = Event.where(venue_id: fake_haunt)

  # $ids_to_exclude = [fake_state_events.first.venue_id, fake_haunt_events.first.venue_id]
  
  def index
    @all_events = Event.where.not(venue_id: $ids_to_exclude).or(Event.where(venue_id: nil))

    # if params[:day]
    #   @day = Date.parse(params[:day])
    #   @events = Event
    #   .where.not(venue_id: $ids_to_exclude).or(Event.where(venue_id: nil))
    #   .where(:start_time => @day.beginning_of_day..@day.end_of_day)
    #   .paginate(page: params[:page])
    # else
    #   @events = Event
    #   .where.not(venue_id: $ids_to_exclude).or(Event.where(venue_id: nil))
    #   .where(:start_time => DateTime.now..DateTime::Infinity.new)
    #   .order(:start_time).paginate(page: params[:page])
    # end 
  end

  def day
    @day = Date.parse(params[:day])
    @events = Event
    .where.not(venue_id: $ids_to_exclude).or(Event.where(venue_id: nil))
    .where(:start_time => @day.beginning_of_day..@day.end_of_day)
    .paginate(page: params[:page])
  end

  def featured_events
    @featured_events = Event.all
    .where.not(venue_id: $ids_to_exclude).or(Event.where(venue_id: nil))
    .select(&:featured_events)
  end

  def search
    @search_results = Event.search(params[:search])
    .where.not(venue_id: $ids_to_exclude)
    .paginate(page: params[:page], per_page: 25)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    # @organization = @event.organization
    # @venue = @event.venue
    
    # @venue_rating = @event.venue.try(:rating) ? @event.venue.rating : 0
    # @org_rating = @event.organization.try(:rating) ? @event.organization.rating : 0


    # @rating = @venue_rating + @org_rating
  end

  # GET /events/new
  def new
    @event = Event.new
    @organizations = Organization.sorted
    @venues = Venue.sorted
  end

  # GET /events/1/edit
  def edit
    @organizations = Organization.sorted
    @venues = Venue.sorted    
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_all
    Event.destroy_all
    redirect_to events_path, notice: "All Events Deleted"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:venue_id, :organization_id, :integer, :name, :description, :text, :url, :cost, :start_time, :end_time, :url)
    end
end
