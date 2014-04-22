class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :destroy, :update, :profile]
  before_action :unread_messages, :find_notifications, :unread_notifications


  def index
    @users = User.all
    @top_badgers = User.joins(:rate_average_without_dimension)
                       .order('rating_caches.avg DESC')
                       .first(20)
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
    @created_tasks = Task.not_posted(@user)
    @posted_tasks = Task.posted_tasks(@user)
    @check_paid_tasks = @posted_tasks.select { |b| b[:paid] == true}
    @archived_tasks = Task.past_posted_tasks(@user)
    @badger_archived_tasks = @user.badger_paid_tasks
    @badger_pending_tasks = @user.pending_tasks
    @badger_accepted_tasks = @user.accepted_not_paid
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
