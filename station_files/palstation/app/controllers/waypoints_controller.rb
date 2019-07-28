class WaypointsController < ApplicationController
  before_action :set_waypoint, only: [:show, :edit, :update, :destroy]

  # GET /waypoints
  # GET /waypoints.json
  def index
    @waypoints = Waypoint.all
  end

  # GET /waypoints/1
  # GET /waypoints/1.json
  def show
  end

  # GET /waypoints/new
  def new
    @waypoint = Waypoint.new
  end

  # GET /waypoints/1/edit
  def edit
  end

  # POST /waypoints
  # POST /waypoints.json
  def create
    @waypoint = Waypoint.new(waypoint_params)

    respond_to do |format|
      if @waypoint.save
        format.html { redirect_to @waypoint, notice: 'Waypoint was successfully created.' }
        format.json { render :show, status: :created, location: @waypoint }
      else
        format.html { render :new }
        format.json { render json: @waypoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waypoints/1
  # PATCH/PUT /waypoints/1.json
  def update
    respond_to do |format|
      if @waypoint.update(waypoint_params)
        format.html { redirect_to @waypoint, notice: 'Waypoint was successfully updated.' }
        format.json { render :show, status: :ok, location: @waypoint }
      else
        format.html { render :edit }
        format.json { render json: @waypoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waypoints/1
  # DELETE /waypoints/1.json
  def destroy
    @waypoint.destroy
    respond_to do |format|
      format.html { redirect_to waypoints_url, notice: 'Waypoint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_waypoint
      @waypoint = Waypoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def waypoint_params
      params.require(:waypoint).permit(:lat, :long, :step, :flightplan_id)
    end
end
