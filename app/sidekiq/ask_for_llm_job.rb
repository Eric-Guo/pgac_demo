class AskForLLMJob < SideKiqBase
  include ApplicationHelper

  def perform(question, new_message_id)
    ai_user = User.find_or_create_by(fingerprint: RubyLLM.config.default_model)
    ai_message = Message.new user_id: ai_user.id, created_at: Time.zone.now
    ActionCable.server.broadcast "room_channel", {id: ai_message.id, message: render_message(ai_message)}

    # calling dify need below
    # chat = RubyLLM.chat(provider: :dify, model: RubyLLM.config.default_model, assume_model_exists: true)
    chat = RubyLLM.chat
    Message.where.not(id: new_message_id).order(id: :asc).all.each do |message|
      role = message.user.ai_assistant? ? :assistant : :user
      _think_content, content = split_think_value(message.content)
      chat.add_message RubyLLM::Message.new(
        role: role,
        content: content,
        conversation_id: message.conversation_id,
        model_id: RubyLLM.config.default_model
      )
    end
    response = chat.ask question do |chunk|
      ActionCable.server.broadcast "room_channel", {id: ai_message.id, content: chunk.content}
    end
    ai_message.update! content: response.content, conversation_id: response.conversation_id
  end
end
