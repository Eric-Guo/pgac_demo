class AskForLLMJob < SideKiqBase
  def perform(question)
    ai_user = User.find_or_create_by(fingerprint: RubyLLM.config.default_model)
    ai_message = Message.new user_id: ai_user.id, created_at: Time.zone.now
    ActionCable.server.broadcast "room_channel", {id: ai_message.id, message: render_message(ai_message)}

    chat = RubyLLM.chat
    Message.order(id: :asc).all.each do |message|
      role = message.user.fingerprint.to_i > 0 ? :user : :assistant
      chat.add_message RubyLLM::Message.new(
        role: role,
        content: message.content,
        model_id: RubyLLM.config.default_model
      )
    end
    response = chat.ask question do |chunk|
      ActionCable.server.broadcast "room_channel", {id: ai_message.id, content: chunk.content}
    end
    ai_message.update! content: response.content
  end
end
