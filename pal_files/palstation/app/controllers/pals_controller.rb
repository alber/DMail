class PalsController < ApplicationController
  before_action :set_pal, only: [:show, :edit, :update, :destroy]

  # GET /pals
  # GET /pals.json
  def index
    @pals = Pal.all
  end

  # GET /pals/1
  # GET /pals/1.json
  def show
  end

  # GET /pals/new
  def new
    @pal = Pal.new
  end

  # GET /pals/1/edit
  def edit
  end

  # POST /pals
  # POST /pals.json
  def create
    @pal = Pal.new(pal_params)

    respond_to do |format|
      if @pal.save
        format.html { redirect_to @pal, notice: 'Pal was successfully created.' }
        format.json { render :show, status: :created, location: @pal }
      else
        format.html { render :new }
        format.json { render json: @pal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pals/1
  # PATCH/PUT /pals/1.json
  def update
    respond_to do |format|
      if @pal.update(pal_params)
        format.html { redirect_to @pal, notice: 'Pal was successfully updated.' }
        format.json { render :show, status: :ok, location: @pal }
      else
        format.html { render :edit }
        format.json { render json: @pal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pals/1
  # DELETE /pals/1.json
  def destroy
    @pal.destroy
    respond_to do |format|
      format.html { redirect_to pals_url, notice: 'Pal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pal
      @pal = Pal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pal_params
      params.require(:pal).permit(:status, :location, :lat, :long, :payload_id, :flightplan_id)
    end
end
