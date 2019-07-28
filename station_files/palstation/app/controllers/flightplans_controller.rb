class FlightplansController < ApplicationController
  before_action :set_flightplan, only: [:show, :edit, :update, :destroy]

  # GET /flightplans
  # GET /flightplans.json
  def index
    @flightplans = Flightplan.all
  end

  # GET /flightplans/1
  # GET /flightplans/1.json
  def show
  end

  # GET /flightplans/new
  def new
    @flightplan = Flightplan.new
  end

  # GET /flightplans/1/edit
  def edit
  end

  # POST /flightplans
  # POST /flightplans.json
  def create
    @flightplan = Flightplan.new(flightplan_params)

    respond_to do |format|
      if @flightplan.save
        format.html { redirect_to @flightplan, notice: 'Flightplan was successfully created.' }
        format.json { render :show, status: :created, location: @flightplan }
      else
        format.html { render :new }
        format.json { render json: @flightplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flightplans/1
  # PATCH/PUT /flightplans/1.json
  def update
    respond_to do |format|
      if @flightplan.update(flightplan_params)
        format.html { redirect_to @flightplan, notice: 'Flightplan was successfully updated.' }
        format.json { render :show, status: :ok, location: @flightplan }
      else
        format.html { render :edit }
        format.json { render json: @flightplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flightplans/1
  # DELETE /flightplans/1.json
  def destroy
    @flightplan.destroy
    respond_to do |format|
      format.html { redirect_to flightplans_url, notice: 'Flightplan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flightplan
      @flightplan = Flightplan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flightplan_params
      params.require(:flightplan).permit(:updated_at, :updated_by, :updated_by_me, :waypoint_count, :last_waypoint, :step_waypoint)
    end
end
