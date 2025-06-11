class AskForLLMJob
  include Sidekiq::Job

  def perform(question)
    chat = RubyLLM.chat(provider: :dify, assume_model_exists: true)
    response = chat.ask question do |chunk|
      ActionCable.server.broadcast "room_channel", {content: chunk.content}
    end
    ai_user = User.find_or_create_by(fingerprint: RubyLLM.config.default_model)
    Message.create! content: response.content, user_id: ai_user.id
  end
end
