class MessagesController < ApplicationController
  before_action :authenticate_user!, :set_user
  before_action :unread_messages, :find_notifications, :unread_notifications


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
    # pulls all receipts for each conversation, last received first
    @conversation = current_user.mailbox.conversations.find(params[:format])
    @receipts = @conversation.receipts_for(current_user).order("created_at desc")
    @receipts = @receipts.paginate(:page => params[:page], :per_page => 10)
 
    @receipts.mark_as_read
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

  def notifications
    @notices = @notices.paginate(:page => params[:page], :per_page => 10)
  end

  def show_notification
    @notice = Notification.find(params[:format])
    @notice.receipts.last.update(is_read: true)
  end

  def inbox
    @conversations = current_user.mailbox.inbox.order("created_at desc")
    @conversations = @conversations.paginate(:page => params[:page], :per_page => 10)
  end

  def sent
    @conversations = current_user.mailbox.sentbox.order("created_at desc")
    @conversations = @conversations.paginate(:page => params[:page], :per_page => 10)
  end

  def trash
    @conversations = current_user.mailbox.trash.order("updated_at desc")
    @conversations = @conversations.paginate(:page => params[:page], :per_page => 10)
  end

  private
  def set_user
    @user = current_user
  end
  def message_params
    params.require(:message).permit(:body, :subject, :recipient_id, :sender_id, :user_id)
  end
end
