class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:user).require(:name, :email, :city, :zipcode, :bio)
  end
end
