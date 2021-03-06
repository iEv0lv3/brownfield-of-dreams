class SessionsController < ApplicationController
  def new
    @new ||= User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def update
    user_response = request.env['omniauth.auth']
    current_user.update_column(:github_token, (user_response['credentials']['token']).to_s)
    current_user.update_column(:github_url, (user_response['info']['urls']['GitHub']).to_s)
    redirect_to dashboard_path, notice: 'Connected to GitHub!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
