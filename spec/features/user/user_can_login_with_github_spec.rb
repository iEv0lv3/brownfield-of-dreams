require 'rails_helper'

RSpec.describe '/auth/github/callback', type: :feature do
  before :each do
    @user1 = User.create!(
      first_name: 'Jordan',
      last_name: 'Williams',
      email: 'jordan@mail.com',
      password: 'none'
    )

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      {
        provider: 'github',
        info: {
          name: @user1.first_name,
          email: @user1.email,
          urls: {
            github_url: 'https://github.com/iEv0lv3'
          }
        },
        uid: '123545',
        credentials: { token: Figaro.env.github_personal_token }
      }
    )

    @session = Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  describe 'When I view my dashboard' do
    it 'I can link my github account', :vcr do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit '/dashboard'

      click_on 'Connect GitHub Account'

      within('.notice') do
        expect(page).to have_content('Connected to GitHub!')
      end
    end
  end
end
