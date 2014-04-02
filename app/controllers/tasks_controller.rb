class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :destroy]

  def index
    @task = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :owner, :paid, :pay, :status, :summary, :due_date, :due_time, :num_workers)
  end

end
