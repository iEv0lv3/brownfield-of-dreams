class FriendshipsController < ApplicationController
  def create
    if current_user.create_friendship(params[:friend_id]) == 'success'
      flash[:notice] = 'Added friend.'
    else
      flash[:error] = 'Unable to add friend.'
    end
    redirect_to dashboard_path
  end
end
