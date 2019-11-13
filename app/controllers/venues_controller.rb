class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in, only: [:edit, :update, :destroy, :new, :create, :remove_all]
 
  # GET /venues
  # GET /venues.json


  # fake_state = Venue.where(remote_id: 298929)
  # fake_haunt = Venue.where(remote_id: 298932)

  # $ids_to_exclude = [fake_state.first.id, fake_haunt.first.id]

  # print fake_state.name

  def index
    @venues = Venue.order(:name)
    .where.not(id: $ids_to_exclude)
    .paginate(page: params[:page], per_page: 25)
  end

  def search
    @search_results = Venue.search(params[:search])
    .where.not(id: $ids_to_exclude)
    .paginate(page: params[:page], per_page: 25)
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @venue_events = Event.where(venue_id: @venue.id).paginate(page: params[:page], per_page: 25)
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: 'Venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_all
    Venue.destroy_all
    redirect_to venues_path, notice: "All Venues Deleted"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name, :address, :description, :text, :url, :remote_id, :rating)
    end
end
