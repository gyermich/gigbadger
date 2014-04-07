class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :bio, :city, :zipcode) }
    end
  # before_action :current_user

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # rescue ActiveRecord::RecordNotFound
  #   reset_session
  #   redirect_to root_path, notice: "Something went wrong!"
  # end
  # helper_method :current_user

  # def authorize
  #   redirect_to root_path, notice: 'Please log in!' if current_user.nil?
  # end
end
