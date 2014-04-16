class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = build_resource # Needed for Merit
    super
    UserMailer.signup_confirmation(@user).deliver
  end

  def update
    @user = resource # Needed for Merit
    super
  end

  def after_sign_up_path_for(resource)
     edit_user_path(current_user)
   end
end