# Preview all emails at http://localhost:3000/rails/mailers/invite_users
class InviteUsersPreview < ActionMailer::Preview
  def preview_inform
    InviteUsersMailer.inform(User.last, { email: 'jordan@mail.com', name: 'jordan' }, 'http://localhost:3000/users')
  end
end
