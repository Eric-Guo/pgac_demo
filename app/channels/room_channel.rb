# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Current.user = User.find_or_create_by(fingerprint: data["fingerprint"])
    new_message = Message.create! content: data["message"], user_id: Current.user.id
    AskForLLMJob.perform_async(data["message"], new_message.id)
  end
end
