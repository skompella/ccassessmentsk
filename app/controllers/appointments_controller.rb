class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
     respond_to do |format|
      if !@appointment.nil?        
        format.json { render action: 'show', status: :success, location: @appointment }
      else
        errorMsg ={  "error" => @error }
        format.json { render json: errorMsg, status: :unprocessable_entity }
      end
    end
  end

  # GET /appointments/import
  def import
  end
  
  #POST /appointments/upload
  def upload
    Appointment.import(params[:file])
  end
  
  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new()
    @appointment.first_name = params[:first_name]
    @appointment.last_name = params[:last_name]
    @appointment.start_time = params[:start_time]
    @appointment.end_time = params[:end_time]
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @appointment }
      else
        format.html { render action: 'new' }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    begin      
      @appointment.destroy
      status_msg ={"message"=>"Deleted Successfully", "id" => params[:id]}
    rescue
      status_msg ={"message"=>"Unable to delete ", "id" => params[:id]}
    end
    respond_to do |format|
      format.html { redirect_to appointments_url }
      
      format.json { render json: status_msg.to_json }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      begin 
        @appointment = Appointment.find(params[:id])
      rescue 
        @error = "Unable to find appointment with ID="+params[:id].to_s
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:first_name, :last_name, :start_time, :end_time, :comments)
    end
end
