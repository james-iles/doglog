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
      #added route
      redirect_to "/users/sign_up", notice: "Great! Now create your account."
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

private

  def household_params
    params.require(:household).permit(:name)
  end

  def redirect_if_signed_in
    if user_signed_in?
      redirect_to user_path(current_user), alert: "You already have an account!"
    end
  end
end
