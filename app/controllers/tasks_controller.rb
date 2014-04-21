class TasksController < ApplicationController
  before_action :set_task, except: [:index, :reset_filterrific, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @filterrific = Filterrific.new(
          Task,
          params[:filterrific] || session[:filterrific_students]
        )
    @tasks = Task.where(status: "available").filterrific_find(@filterrific)
    @tasks = @tasks.paginate(page: params[:page], per_page: 12)

    # Persist the current filter settings in the session as a plain old Hash.
    session[:filterrific_tasks] = @filterrific.to_hash
    respond_to do |format|
          format.html
          format.js
    end
  end

  def reset_filterrific
      session[:filterrific_tasks] = nil
      redirect_to action: :index
    end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      @task.categories = params[:task][:categories].present? ? Category.find_all_by_id(params[:task][:categories]) : [ ]
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      @task.categories = params[:task][:categories].present? ? Category.find_all_by_id(params[:task][:categories]) : [ ]
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def edit
  end

  def post
    if @task.update(status: "available")
      redirect_to tasks_path, notice: "Yay! Your gig is posted!"
    else
      redirect_to task_path
    end
  end

  def complete
    if @task.update(status: "completed")
      Resque.enqueue(BadgeJob, @task.id)
      redirect_to action: :rate_workers
    else
      redirect_to :back, notice: "Something went wrong."
    end
  end

  def worker_is_paid
    if @task.update(is_paid: true)
      redirect_to user_path(current_user)
    else
      redirect_to :back, notice: "Something went wrong."
    end
  end

  def rate_workers
    @workers = @task.workers
  end

  def show
  end

  def offers
    @offers = @task.pending_users
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :owner_id, :paid, :pay, :status, :summary, :due_date)
  end
end
