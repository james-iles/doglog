class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @household = current_user.household
    @user = current_user
  end
end
