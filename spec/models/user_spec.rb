require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'model method tests', :vcr do
    before :each do
      @user = User.create!(
        email: 'cg@mail.com',
        first_name: 'Childish',
        last_name: 'Gambino',
        password: 'none',
        role: :default,
        activated: 1,
        confirm_token: Faker::Crypto.md5,
        github_token: Figaro.env.github_personal_token.to_s,
        github_url: 'https://github.com/iEv0lv3'
      )
    end

    it 'my repos' do
      expect(@user.my_repos).to include(Repo)
    end

    it 'my followers' do
      expect(@user.my_followers).to include(Follower)
    end

    it 'following' do
      expect(@user.following).to include(Follower)
    end
  end
end
