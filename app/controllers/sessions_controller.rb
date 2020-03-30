class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
    @user = User.new
  end

  def create
    if @user = User.find_by(name: user_params[:name])
      if @user.authenticate(user_params[:password])
        flash[:notice] = "Logged in as #{@user.name.capitalize}"
        log_in @user
        redirect_to @user
      else
        flash[:notice] = "Invalid password"
        redirect_to login_path 
      end
    else
      flash[:notice] = "User not found"
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end
end