class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.includes(:dog).all
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @dog = Dog.find(params[:dog_id])
    @appointment = Appointment.new
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @appointment = Appointment.new(appointment_params)
    @appointment.dog = @dog


    if @appointment.save
      redirect_to @appointment, notice: 'Appointment created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
    redirect_to appointment_path(@appointment)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    @dog = Dog.find(params[:dog_id])
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to dog_appointments_path(appointment.dog), notice: "Appointment deleted"
  end

  private

  def appointment_params
    params.require(:appointment).permit(:title, :start_time, :end_time, :appointment_type, :location, :appointment_notes, :host)
  end
end
