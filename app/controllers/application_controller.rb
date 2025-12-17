class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
  
  protected

  def after_sign_in_path_for(resource)
    household_dogs_path(resource.household)
  end
end
