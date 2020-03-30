class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = current_user
    # @user = User.find_by(id: params[:id])
  end

  def index
    if params[:event_id]
      @event = Event.find_by(id: params[:event_id])
    end
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end
end
