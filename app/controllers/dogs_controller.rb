class DogsController < ApplicationController
  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
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
    @dog.destroy
    redirect_to dogs_path, notice: "Dog deleted"
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :dob)
  end
end
