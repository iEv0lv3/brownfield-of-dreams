class AccountActivationMailer < ApplicationMailer
  def inform(new_user, url)
    @user = new_user
    @url = url
    mail(to: @user.email, subject: "#{@user.first_name}: Please activate your account!")
  end
end
