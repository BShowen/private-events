class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = User.find_by(name: user_params[:name])
      if @user.authenticate(user_params[:password])
        log_in @user
        redirect_to @user
      else
        redirect_to login_path 
      end
    else
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