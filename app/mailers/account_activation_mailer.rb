class AccountActivationMailer < ApplicationMailer
  def inform(current_user)
    @user = current_user
    mail(to: @user.email, subject: "#{@user.first_name}: Please activate your account!")
  end
end
