class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticateUser(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      flash.now[:notice] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    flash.now[:notice] = "Logged out successfully!"
    redirect_to login_path
  end
end
