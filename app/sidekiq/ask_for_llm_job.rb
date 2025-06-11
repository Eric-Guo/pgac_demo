class AskForLLMJob
  include Sidekiq::Job

  def perform(question)
    ai_user = User.find_or_create_by(fingerprint: RubyLLM.config.default_model)
    ai_message = Message.new user_id: ai_user.id, created_at: Time.zone.now
    ActionCable.server.broadcast "room_channel", {id: ai_message.id, message: render_message(ai_message)}

    chat = RubyLLM.chat(provider: :dify, assume_model_exists: true)
    response = chat.ask question do |chunk|
      ActionCable.server.broadcast "room_channel", {id: ai_message.id, content: chunk.content}
    end
    ai_message.update! content: response.content
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: "messages/message", locals: {message: message})
  end
end
