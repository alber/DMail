class PayloadsController < ApplicationController
  before_action :set_payload, only: [:show, :edit, :update, :destroy]

  # GET /payloads
  # GET /payloads.json
  def index
    @payloads = Payload.all
  end

  # GET /payloads/1
  # GET /payloads/1.json
  def show
  end

  # GET /payloads/new
  def new
    @payload = Payload.new
  end

  # GET /payloads/1/edit
  def edit
  end

  # POST /payloads
  # POST /payloads.json
  def create
    @payload = Payload.new(payload_params)

    respond_to do |format|
      if @payload.save
        format.html { redirect_to @payload, notice: 'Payload was successfully created.' }
        format.json { render :show, status: :created, location: @payload }
      else
        format.html { render :new }
        format.json { render json: @payload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payloads/1
  # PATCH/PUT /payloads/1.json
  def update
    respond_to do |format|
      if @payload.update(payload_params)
        format.html { redirect_to @payload, notice: 'Payload was successfully updated.' }
        format.json { render :show, status: :ok, location: @payload }
      else
        format.html { render :edit }
        format.json { render json: @payload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payloads/1
  # DELETE /payloads/1.json
  def destroy
    @payload.destroy
    respond_to do |format|
      format.html { redirect_to payloads_url, notice: 'Payload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payload
      @payload = Payload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payload_params
      params.require(:payload).permit(:created_at, :is_sent, :is_received, :pal_id)
    end
end
