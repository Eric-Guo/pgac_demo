class MessageBroadcastJob < SideKiqBase
  def perform(message_id, current_user_id)
    message = Message.find(message_id)
    Current.user = User.find_by(id: current_user_id)
    ActionCable.server.broadcast "room_channel", {id: message.id, message: render_message(message)}
  end
end
