class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    recipient = User.find(params[:user_id])
    create = current_user.send_message(recipient, params[:body], params[:subject])

    if create.save
      redirect_to user_messages_sent_path, notice: "Message sent"
    else
      render :new
    end
  end

  def show
    conversation = current_user.mailbox
    @messages = conversation.receipts_for(current_user)
    # shows conversation, last receipt shown first 
    # newest message received
  end

  def reply
    receipt = Receipt.find(params[:id])
    current_user.reply_to_sender(receipt, params[:body])
  end

  def delete_message
    # deletes one message from conversation
    message = current_user.receipt
    message.move_to_trash(current_user)
  end

  def delete_conversation
    # deletes conversation for one participant
    conversation.move_to_trash(current_user)
  end

  def inbox
    @conversations = current_user.mailbox.inbox
    # .page(params[:page]).per(9)
  end

  def sent
    @conversations = current_user.mailbox.sentbox
    # .page(params[:page]).per(9)
  end

  def trash
    @conversations = current_user.mailbox.trash
    # .page(params[:page]).per(9)
  end

  private
  def message_params
    params.require(:message).permit(:body, :subject, :recipient_id, :sender_id, :user_id)
  end
end
