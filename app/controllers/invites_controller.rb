class InvitesController < ApplicationController
  def create
    invited = params[:github_handle]
    invited_info = GithubService.new(current_user).find_users(invited)
    if !invited_info[:email].nil?
      InviteUsersMailer.inform(current_user, invited_info, request.url).deliver_now
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end
