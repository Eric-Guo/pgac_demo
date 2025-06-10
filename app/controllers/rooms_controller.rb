class RoomsController < ApplicationController
  def show
    @messages = Message.all

    if cookies[:fingerprint]
      @current_user = User.find_or_create_by(fingerprint: cookies[:fingerprint])
    end
  end
end
