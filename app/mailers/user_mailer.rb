class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers

  default from: "gigbadger@notifications.com"

  def confirmation_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :reset_password_instructions, opts)
  end

  def unlock_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :unlock_instructions, opts)
  end


  def signup_confirmation(user)
     @user = user
     mail :to => user.email, :subject=> "Thank you for signing up with GigBadger"
  end

  # send password reset instructions

  def reset_password_instructions(user)
    @resource = user
    mail(:to => @resource.email, :subject => "Reset password instructions", :tag => 'password-reset', :content_type => "text/html") do |format|
     format.html { render "devise/mailer/reset_password_instructions" }
    end
  end
end
