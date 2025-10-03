class TasksController < ApplicationController
  def index
    if params[:sort].present? && params[:direction].present?
      session[:sort] = params[:sort]
      session[:direction] = params[:direction]
    end

    sort_column   = params[:sort].in?(%w[create_time end_time id]) ? params[:sort] : "id"
    sort_direction = params[:direction].in?(%w[asc desc]) ? params[:direction] : "desc"
    @tasks = Task.order(sort_column => sort_direction)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = t("notice.createSuccess")
      redirect_to root_path
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
    redirect_to root_path
  end

  private

  def task_params
    params.expect(task: [ :name, :create_time, :end_time, :status, :priority, :tag ])
  end
end
