class RoomsController < ApplicationController
  def show
    @messages = Message.order(id: :asc).all
  end
end
