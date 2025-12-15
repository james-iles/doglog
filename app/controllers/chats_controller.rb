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
    @dog = @chat.dog
    @message = Message.new
  end

  def save_summary
    @chat = Chat.joins(dog: :household)
                .where(households: { id: current_user.household_id })
                .find(params[:id])

    conversation = @chat.messages.order(:created_at).map do |msg|
      "#{msg.role.capitalize}: #{msg.content}"
    end.join("\n\n")

    summary_prompt = "Save a summary of the key points of this chat, capturing the main advice, tips and actions for the user to remember. The summary should be no more than 300 words and should be in Markdown format, with approriate spacing between blocks of text, for easy reading."

    ruby_llm_chat = RubyLLM.chat
    response = ruby_llm_chat.with_instructions(summary_prompt).ask(conversation)

    dog = @chat.dog
    dog.documents.create!(
      title: "Chat Summary: #{@chat.title}",
      content: response.content,
      category: "Chat"
    )

    @chat.destroy

    redirect_to dog_documents_path(dog), notice: "Chat summary saved successfully."
  end

  def destroy
    @chat = Chat.joins(dog: :household)
                .where(households: { id: current_user.household_id })
                .find(params[:id])

    dog = @chat.dog
    @chat.destroy

    redirect_to dog_path(dog), notice: "Chat ended."
  end

  private

  def chat_params
    params.fetch(:chat, {}).permit(:title)
  end

end
