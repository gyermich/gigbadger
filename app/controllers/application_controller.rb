require 'notice'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name) }
    end

  def find_notifications
    if current_user
      @notices = Receipt.joins(:notification)
                      .where("receiver_id = ?", current_user.id)
                      .where("notification_code = ?
                              OR notification_code = ?
                              OR notification_code = ?",
                              "reject_offers",
                              "accept_offer",
                              "badge")
                      .order("created_at desc")
    end
  end

  def unread_notifications
    if current_user
      @notification_count = @notices.where(is_read: false).count || 0
    end
  end

  def unread_messages
    if current_user 
      @unread_messages = current_user.mailbox.inbox({:read => false}).count || 0
    end
  end

end
