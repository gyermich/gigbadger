class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]


  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Thank you for signing up!'
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to :back
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :city, :zipcode, :bio, :password, :password_confirmation)
  end
end
