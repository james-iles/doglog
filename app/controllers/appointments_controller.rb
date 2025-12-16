class AppointmentsController < ApplicationController
  def index
    @dog = Dog.find(params[:dog_id])
    @appointments = @dog.appointments.order(created_at: :desc)
      if params[:query].present?
      sql_subquery = "title ILIKE :query OR appointment_notes ILIKE :query"
      @appointments = @appointments.where(sql_subquery, query: "%#{params[:query]}%")
      end

      if params[:appointment_type].present? && params[:appointment_type] != "all"
      @appointments = @appointments.where(appointment_type: params[:appointment_type])
      end
  end


  def show
    @appointment = Appointment.find(params[:id])
    @dog = @appointment.dog
  end


  def new
    @dog = Dog.find(params[:dog_id])
    @appointment = Appointment.new

    # Set default times in the correct format for datetime-local
    @appointment.start_time = Time.current.change(sec: 0)
    @appointment.end_time = (Time.current + 1.hour).change(sec: 0)
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @appointment = Appointment.new(appointment_params)
    @appointment.dog = @dog

    # Parse datetime strings if they're in ISO format
    if params[:appointment][:start_time].present?
      @appointment.start_time = Time.zone.parse(params[:appointment][:start_time])
    end

    if params[:appointment][:end_time].present?
      @appointment.end_time = Time.zone.parse(params[:appointment][:end_time])
    end

    if @appointment.save
      redirect_to dog_appointments_path(@dog), notice: 'Appointment created successfully'
    else
      flash[:alert] = @appointment.errors.full_messages.join(", ")
      redirect_to dog_appointments_path(@dog)
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @dog = @appointment.dog
  end

  def update
    @appointment = Appointment.find(params[:id])
    @dog = @appointment.dog

    # Parse datetime-local strings
    if params[:appointment][:start_time].present?
      params[:appointment][:start_time] = DateTime.parse(params[:appointment][:start_time])
    end

    if params[:appointment][:end_time].present?
      params[:appointment][:end_time] = DateTime.parse(params[:appointment][:end_time])
    end

    if @appointment.update(appointment_params)
      redirect_to appointment_path(@appointment), notice: 'Appointment updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to dog_appointments_path(@appointment.dog), status: :see_other, notice: "Appointment deleted"
  end

  private

  def appointment_params
    params.require(:appointment).permit(:title, :start_time, :end_time, :appointment_type, :location, :appointment_notes, :host)
  end
end
