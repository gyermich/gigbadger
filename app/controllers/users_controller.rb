class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :destroy, :update, :profile]

  def index
    @users = User.all
    @top_badgers = User.joins(:rate_average_without_dimension)
                       .order('rating_caches.avg DESC')
                       .first(10)
  end

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

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show
    @created_tasks = Task.where(owner_id: @user.id)
    @badger_tasks = @user.tasks
    @badges = @user.badges
      unless @user == current_user
        redirect_to root_path, notice: "Sorry, you are not authorized to access this page."
      end
  end

  def profile
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :city, :zipcode, :bio, :password, :password_confirmation, :image)
  end
end
