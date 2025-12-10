class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @household = current_user.household
      @user = current_user
    end
  end
end
