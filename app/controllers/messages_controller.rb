class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find(params[:format])
  end

  def create
    recipient = User.find(params[:recipient_id])
    create = current_user.send_message(recipient, params[:body], params[:subject])

    if create.save
      redirect_to root_path, notice: "Message sent"
    else
      render :new
    end
  end

  def show
    conversation = current_user.mailbox.conversations.find(params[:format])
    @receipts = conversation.receipts_for(current_user)
    @receipts.mark_as_read

    # shows conversation, last receipt shown first 
    # newest message received
  end

  def conversation
    @conversation = current_user.mailbox.conversations.find(params[:format])
    @receipts = @conversation.receipts_for(current_user)
  end

  def reply
    messages = Conversation.find(params[:conversation])
    respond = current_user.reply_to_conversation(messages, params[:body]) 

    if respond.save
      redirect_to messages_inbox_path, notice: "Your message was sent"
    else
      render :conversation
    end
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
