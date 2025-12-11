class ChatsController < ApplicationController

  def create
    @dog = Dog.find(params[:dog_id])

    unless @dog.household == current_user.household
      redirect_to root_path, alert: "Not authorized."
      return
    end
    @chat = Chat.new(title: Chat::DEFAULT_TITLE)
    @chat.dog = @dog

    if @chat.save
      redirect_to chat_path(@chat), notice: "Chat created successfully"
    else
      redirect_to dog_path(@dog), alert: "Could not create chat"
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    # Do we need to be checking user/household_id at this point to show only relevant chats?
    # I think not as we don't have a history of hats to show...
  end

  private

  def chat_params
    params.fetch(:chat, {}).permit(:title)
  end

end
