class MessagesController < ApplicationController

  SYSTEM_PROMPT = "You are a Teaching Assistant.\n\nI am a student at the Le Wagon AI
  Software Development Bootcamp, learning how to code.\n\nHelp me break down my problem
  into small, actionable steps, without giving away solutions.\n\nAnswer concisely
  in Markdown."

  def create
    @household = current_user.household_id
    # raise
    @chat = @@household.chats.find(params[:chat_id])
    @challenge = @chat.challenge

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save

    else

    end
  end
end
