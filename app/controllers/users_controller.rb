class UsersController < ApplicationController
  def show
    @user = User.find_by(id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      AccountActivationMailer.inform(user).deliver_now
      flash[:success] = 'Please check your email to activate account.'
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
