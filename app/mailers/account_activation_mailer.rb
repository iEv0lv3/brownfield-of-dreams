class AccountActivationMailer < ApplicationMailer
  def inform(new_user)
    @user = new_user
    mail(to: @user.email, subject: "#{@user.first_name}: Please activate your account!")
  end
end
