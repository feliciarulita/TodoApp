class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password_digest])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      flash.now[:notice] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "Logged out successfully!"
    redirect_to login_path
  end
end
