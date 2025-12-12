class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @household = current_user.household
      @user = current_user
    end
  end

  def dashboard
    @household = current_user.household
    @dogs = @household.dogs.with_attached_photo
    @chat_summaries = Document.where(dog: @dogs, category: "Chat").order(created_at: :desc)
  end
end
