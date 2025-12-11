class Chat < ApplicationRecord
  belongs_to :dog
  has_many :messages, dependent: :destroy

  DEFAULT_TITLE = "New Chat"
  TITLE_PROMPT = <<~PROMPT
    Generate a relevant and concise title, of no more than 6 words, that summarizes
    the user's question for this chat conversation.
    PROMPT

  def generate_title_from_first_message
    return unless title == DEFAULT_TITLE

    first_assistant_message = messages.where(role: "assistant").order(:created_at).first
    return if first_assistant_message.nil?
    response = RubyLLM.chat.with_instructions(TITLE_PROMPT).ask(first_assistant_message.content)
    update(title: response.content)
  end
end
