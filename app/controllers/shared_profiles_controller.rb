class SharedProfilesController < ApplicationController
  skip_before_action :authenticate_user!, if: :devise_controller_exists?
  before_action :set_profile
  before_action :check_if_active
  before_action :verify_pin, only: [:show]
  before_action :hide_navbar

  def show
    @dog = @shareable_profile.dog
    @profile_data = @dog.profile_data_for(@shareable_profile.shared_categories)

    # Log the view
    @shareable_profile.increment_view!(ip_address: request.remote_ip)
  end

  def pin_entry
    # Renders the PIN entry form
  end

  def verify_pin
    if @shareable_profile.authenticate_access_pin(params[:pin])
      session["verified_profile_#{@shareable_profile.id}"] = true
      redirect_to shared_dog_profile_path(token: params[:token])
    else
      flash.now[:alert] = 'Invalid PIN. Please try again.'
      render :pin_entry, status: :unauthorized
    end
  end

  private

  def set_profile
    @shareable_profile = ShareableProfile.find_by!(token: params[:token])
  rescue ActiveRecord::RecordNotFound
    render plain: 'Profile not found', status: :not_found, layout: false
  end

  def check_if_active
    return if @shareable_profile.active?
    render :expired, status: :gone
  end

  def verify_pin
    return if @shareable_profile.access_pin_digest.blank?
    return if session["verified_profile_#{@shareable_profile.id}"]
    render :pin_entry
  end

  def hide_navbar
    @hide_navbar = true
  end

  def devise_controller_exists?
    defined?(Devise)
  end
end
