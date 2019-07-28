class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages/outgoing.json
  def outgoing
    ### @messages = Message.find_by is_sent: false
    @messages = Message.where(is_sent: false)
  end

  # GET /messages/outbound/1
  def outbound
    @messages = Message.where(is_sent: false, destination_id: params[:id]) 
    render layout: false
  end

  def outbound_confirmed
    all_valid = true
    @messages = Message.where(is_sent: false, destination_id: params[:id]) 
   
    @messages.each do |msg|
      msg.is_sent = true
      isupdated = msg.save!
      all_valid &= isupdated
    end
    
    if all_valid
      render plain:'OK', status: 201, layout: false
    else
      render plain:'Error', status: 501, layout: false
    end
  end

  def outbound_unconfirmed
    @messages = Message.where(is_sent: true, is_received: false, destination_id: params[:id])
    render layout: false
  end

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        ### format.json { render :show, status: :ok, location: @message }
        format.json { render plain:'OK|', status: 201, layout: false  }
      else
        format.html { render :edit }
        ### format.json { render json: @message.errors, status: :unprocessable_entity }
        format.json { render plain:'Error|', status: 501, layout: false  }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:id, :author, :authored, :authored_at, :format, :body, :data, :received_at, :received_by, :received_by_me, :is_received, :is_sent, :jump, :destination_id, :final_destination_id, :manifest)
    end
end
