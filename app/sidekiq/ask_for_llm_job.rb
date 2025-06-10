class AskForLLMJob
  include Sidekiq::Job

  def perform(question)
    chat = RubyLLM.chat(provider: :dify, assume_model_exists: true)
    response = chat.ask question
    Message.create! content: response.content
  end
end
