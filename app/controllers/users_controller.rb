require './app/models/github/repo'

class UsersController < ApplicationController
  def show
    repo_response = Faraday.get("https://api.github.com/user/repos?access_token=#{Figaro.env.github_personal_token}")
    user_body = JSON.parse(repo_response.body, symbolize_names: true)
    repos = user_body[1..5]
    @repo_objects = repos.map do |repo|
      Repo.new(repo)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
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
