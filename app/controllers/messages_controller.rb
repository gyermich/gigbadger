class MessagesController < ApplicationController

  def new
  end

  def create
    recipient = User.find(params[recipient_id])
    current_user.send_message(recipient, params[:body], params[:subject])
  end
end
