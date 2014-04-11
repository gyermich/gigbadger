class UserTaskController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    badger = UserTask.create(task_id: @task.id, user_id: current_user.id)
  
    if badger.save
      redirect_to task_path(@task), notice: "Your offer was sent!"
    else
      redirect_to task_path(@task), notice: "Something went wrong. Place your offer again."
    end
  end

  def check_badger
    @task = Task.find(params[:task_id])

    if UserTask.badger_for_task?(@task, current_user)
      self.create
    else
      redirect_to task_path(@task), notice:"You already sent an offer. Please wait for a response from owner."
    end
  end

end