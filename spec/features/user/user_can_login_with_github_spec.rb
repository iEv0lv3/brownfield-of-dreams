require 'rails_helper'

RSpec.describe 'GET /auth/github/callback', type: :request do
  before :each do
    OmniAuth.config.mock_auth[:github] = nil
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      {
        provider: 'github',
        uid: '123545',
        info: {
          first_name: 'Jordan',
          last_name: 'Williams',
          email: 'jordan@example.com'
        },
        credentials: {
          github_token: '123456',
          expires_at: false
        }
      }
    )

    @session = Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  describe 'When I view my dashboard' do
    it 'I can link my github account', :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      get '/auth/github'

      expect(response.header['Location']).to eq("http://www.example.com/auth/github/callback")
      expect(@session['info']['first_name']).to eq('Jordan')
      expect(@session['info']['email']).to eq('jordan@example.com')
      expect(@session['credentials']['github_token']).to eq('123456')

    end
  end
end
