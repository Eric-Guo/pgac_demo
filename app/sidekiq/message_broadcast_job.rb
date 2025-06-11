class MessageBroadcastJob
  include Sidekiq::Job

  def perform(message_id)
    message = Message.find(message_id)
    ActionCable.server.broadcast "room_channel", {message: render_message(message)}
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: "messages/message", locals: {message: message})
  end
end
