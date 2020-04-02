class InviteUsersMailer < ApplicationMailer
    def inform(user, invited_data, url)
        @user = user
        @invited_user = invited_data[:email]
        @invited_user_name = invited_data[:name]
        @email = invited_data[:email]
        @url = url.gsub('invite','register')
        mail(to: @email, subject: "#{@user_name} has invited you to Turing Tutorials!")
    end 
end
