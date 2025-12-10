class ChatsController < ApplicationController

  def create
    @dog = Dog.find(params[:dog_id])

    unless @dog.household == current_user.household
      redirect_to root_path, alert: "Not authorized."
      return
    end
    @dog.chats.new(chat_params)

    if @chat.save
      redirect_to chat_path(@chat), notice: "Chat created successfully"
    else
      redirect_to dog_path(@dog), alert: "Could not create chat"
    end
  end

  def show
    @chat = Chat.find(params[:id])
  end

  private

  def chat_params
    params.fetch(:chat, {}).permit(:title)
  end

end
