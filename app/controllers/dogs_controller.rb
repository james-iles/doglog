class DogsController < ApplicationController
  def index
    @household = Household.find(params[:household_id])
    @dogs = @household.dogs
    @hide_navbar = true
  end

  def show
    @dog = Dog.find(params[:id])
    @household = @dog.household
  end

  def new
    @household = Household.find(params[:household_id])
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.household = current_user.household

    if @dog.save
      redirect_to dog_path(@dog), notice: "Dog created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def edit_medical_info
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    if @dog.update(dog_params)
      redirect_to dog_path(@dog), notice: "Dog updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    household = @dog.household
    @dog.destroy
    redirect_to edit_household_path(household), notice: "#{@dog.name} has been removed from the household"
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :dob, :weight, :gender, :photo, :vet_name, :vet_clinic, :vet_phone, :vet_address, :insurance_provider, :insurance_policy_number, :microchip_number, :special_notes)
  end
end
