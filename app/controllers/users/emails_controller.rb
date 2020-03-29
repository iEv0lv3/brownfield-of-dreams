class Users::EmailsController < Users::BaseController
  def show
    @user = User.find_by(confirm_token: params[:confirm])
    if @user
      @user.update_column(:activated, 1)
      flash[:success] = 'Account activated!'
    else
      flash[:error] = 'Sorry, activation token does not exist'
      redirect_to root_path
    end
  end
end
