class MessagesController < ApplicationController

  SYSTEM_PROMPT = "You are a canine professional specialising braodly in things like healthcare, pet ownership advice, dog training, behavioural issues and animal ownership.\n\n
  I am an owner of a dog that cares about accurate information, the best possible care, and simple advice.\n\n
  Help me get quality advice, some possible actions to consider and factual information about the content of my message, considering information like breed, age and allergies. For medical issues, despite what the user may ask, beyond a general suggestions of what to consider do not offer any medical advice that could put an animal at risk (like administering any kind of medication or treatment) and instead suggest the user seeks professional advice.\n\n
  Answer concisely and caringly, referring me to an in-person professional if you consider that the best approach."

  def create
    @chat = Chat.joins(dog: :household)
              .where(households: { id: current_user.household_id })
              .find(params[:chat_id])

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      ruby_llm_chat = RubyLLM.chat

      response = ruby_llm_chat.with_instructions(instructions).ask(@message.content)

      @chat.messages.create!(
        role: "assistant",
        content: response.content
      )

      @chat.generate_title_from_first_message

      redirect_to chat_path(@chat)

    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def dog_information
    @dog = @chat.dog
    @extra_info = "Here is some information about the dog:
    Name: #{@dog.name},
    Breed: #{@dog.breed},
    Age in months: #{@dog.age_in_months},
    Gender: #{@dog.gender},
    Allergies: #{@dog.allergies},
    Medications: #{@dog.medications}.
    If anything you need is missing, don't assume or guess, just offer a more general response."
    @extra_info
  end

  def instructions
    [SYSTEM_PROMPT, dog_information].compact.join("\n\n")
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
