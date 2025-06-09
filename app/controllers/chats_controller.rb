class ChatsController < ApplicationController
  def destroy
    Message.delete_all
    redirect_to root_path
  end
end
