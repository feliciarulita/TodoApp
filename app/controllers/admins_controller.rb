class AdminsController < ApplicationController
  before_action :require_admin
  before_action :set_users, only: [ :index, :show ]

  def index
    @pagy, @users = pagy(@users, items: 7)
  end

  def show
    @user = @users.find(params[:id])
    @tasks = @user.tasks
  end

  def new
    @user = User.new(manager: false)
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = t("notice.createUserSuccess")
      redirect_to admins_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = t("notice.updateUserSuccess")
      redirect_to admin_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = t("notice.deleteUserSuccess")
    redirect_to admins_path
  end

  private

  def require_admin
    unless current_user&.manager?
      flash[:notice] = t("notice.adminRestriction")
      redirect_to tasks_path
    end
  end

  def user_params
    params.expect(user: [ :name,  :email, :password, :manager ])
  end

  def set_users
    @users = User.left_joins(:tasks).select("users.*, COUNT(tasks.id) AS tasks_count").group("users.id")
  end
end
