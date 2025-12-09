class DogsController < ApplicationController
  def index
    @household = Household.find(params[:household_id])
    @dogs = @household.dogs
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def new
    @household = Household.find(params[:household_id])
    @dog = @household.dogs.new
  end

  def create
    @household = Household.find(params[:household_id])
    @dog = @household.dogs.new(dog_params)
    if @dog.save
      redirect_to dog_path(@dog), notice: "Dog created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    if @dog.update(dog_params)
      redirect_to dog_path(@dog), notice: "Dog updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    @household = @dog.household
    @dog.destroy
    redirect_to household_path(@household), notice: "Dog deleted."
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :dob)
  end
end
