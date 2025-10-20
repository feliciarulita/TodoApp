class UserRegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: I18n.t("notice.registrationSuccess")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :name, :email, :password, :password_confirmation, :manager ])
  end
end
