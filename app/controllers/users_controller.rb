class UsersController < ApplicationController
  def index
    if current_user.blank?
      render plain: '401 Unauthorized', status: :unauthorized
    end
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "New user created!"
      redirect_to users_path
    else
      flash[:alert] = "Error creating new user!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
