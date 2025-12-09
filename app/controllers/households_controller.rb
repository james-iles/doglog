class HouseholdsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :redirect_if_signed_in, only: [:new, :create]

  def new
    @household = Household.new
  end

  def create
    @household = Household.new(household_params)

    if @household.save
      session[:household_id] = @household.id
      redirect_to new_user_registration_path
    else
      render :new
    end
  end


  def destroy
    @household = Household.find(params[:id])
    @household = Household.destroy
    redirect_to root_path
  end

  def update
    @household = Household.find(params[:id])
    @household.update(params[household_params])
    redirect_to root_path
  end
end

private

  def household_params
    params.require(:household).permit(:name)
  end
end
