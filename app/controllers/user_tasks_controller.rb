class UserTasksController < ApplicationController
  before_action :set_task, :set_user

  def create
    if badger_exists?(@task) == nil
      UserTask.create(task_id: @task.id, user_id: current_user.id)
      redirect_to task_path(@task), notice: "Your offer was sent!"
    else
      redirect_to task_path(@task), notice: "You already placed an offer for this task. Please wait for a response."
    end
  end

  def badger_exists?(task)
    return true if UserTask.find_by(user_id: current_user.id, task_id: task.id)
  end

  def accept_offer
    offer = UserTask.find_by(task_id: @task.id, user_id: @user.id)
    accept = offer.update_status_accept
    update_task_progress

    if accept
      Resque.enqueue(EmailJob, @user.id, @task.id)
      # UserMailer.offer_accepted(@user, @task).deliver
      redirect_to root_path, notice: "You accepted an offer"
    else
      # change below later
      redirect_to root_path, notice: "Oops, something went wrong"
    end
  end

  def update_task_progress
    @task.in_progress
  end

  private
  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_task_params
    params.permit(:user_task).require(:user_id, :task_id, :status)
  end

end