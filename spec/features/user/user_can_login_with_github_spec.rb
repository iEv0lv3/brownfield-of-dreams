require 'rails_helper'

RSpec.describe 'As a user', type: :feature do

  describe 'When I view my dashboard' do
    vcr_options = { :record => :new_episodes }
    it "I see a link to login to github", :js, :vcr => vcr_options do

      @user = create(:user, token: Figaro.env.github_personal_token)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/dashboard'

      
    end
  end
end
