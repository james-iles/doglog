class ShareableProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dog
  before_action :set_shareable_profile, only: [:show, :destroy, :analytics]

  def new
    @shareable_profile = @dog.shareable_profiles.build(
      expires_at: 7.days.from_now
    )
  end

  def create
    @shareable_profile = @dog.shareable_profiles.build(shareable_profile_params)

    if @shareable_profile.save
      redirect_to dog_shareable_profile_path(@dog, @shareable_profile),
                  notice: 'Share link created successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @qr_code = @shareable_profile.qr_code_svg
    @share_url = @shareable_profile.public_url
  end

  def destroy
    @shareable_profile.destroy
    redirect_to dog_path(@dog), notice: 'Share link deleted successfully'
  end

  def analytics
    @view_logs = @shareable_profile.view_logs.order(viewed_at: :desc)
  end

  private

  def set_dog
    @dog = current_user.household.dogs.find(params[:dog_id])
  end

  def set_shareable_profile
    @shareable_profile = @dog.shareable_profiles.find(params[:id])
  end

  def shareable_profile_params
    params.require(:shareable_profile).permit(
      :expires_at,
      :access_pin,
      :max_views,
      shared_categories: []
    )
  end
end
