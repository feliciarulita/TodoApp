class TasksController < ApplicationController
  def index
    @q = current_user.tasks.ransack(params[:q])

    @tasks = @q.result

    if params[:sort].present? && params[:direction].present?
      session[:sort] = params[:sort]
      session[:direction] = params[:direction]
    end

    @pagy, @tasks = pagy(@tasks.sorted(session[:sort], session[:direction]), limit: 7)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    if logged_in?
      @task = Task.new
    else
      redirect_to tasks_path, notice: "Login first!", status: :see_other
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:notice] = t("notice.createSuccess")
      redirect_to tasks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = t("notice.updateSuccess")
      redirect_to task_path(@task)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = t("notice.deleteSuccess")
    redirect_to tasks_path
  end

  private

  def task_params
    params.expect(task: [ :name, :create_time, :end_time, :status, :priority, :tag ])
  end
end
