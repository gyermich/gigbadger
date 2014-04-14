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
    # pulls all conversations, last received first
    # pulls all receipts for each conversation, last received first
    # marks 
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

  def move_to_trash
    # this would be nice if user can trash only one receipt, do later
    @conversation = Conversation.find(params[:format])
    @conversation.move_to_trash(current_user)

    if @conversation.save
      redirect_to messages_trash_path, notice: "Message moved to trash"
    else
      render :conversation
    end
  end

  def delete_from_trash
    @conversation = Conversation.find(params[:format])
    @conversation.mark_as_deleted(current_user)

    if @conversation.save
      redirect_to messages_trash_path, notice: "Message permanently deleted"
    else
      render :trash
    end
  end

  def notices
    @notices = 
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
  end

  private
  def message_params
    params.require(:message).permit(:body, :subject, :recipient_id, :sender_id, :user_id)
  end
end
