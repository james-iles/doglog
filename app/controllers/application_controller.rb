class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  #redirect after sign up

end
