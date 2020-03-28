require 'rails_helper'

RSpec.describe 'As a user', type: :feature do

  describe 'When I view my dashboard' do
    it 'I can see all of my github followers', :vcr do

      @user = create(:user, token: Figaro.env.github_personal_token)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/dashboard'

      within(".github") do
        expect(page).to have_link('cpsoinos')
        expect(page).to have_link('kalyco')
        expect(page).to have_link('ericaashley')
        expect(page).to have_link('meredithkfwilliams')
        expect(page).to have_link('paulmthiebauth')
      end
    end
  end

  describe 'When I view my dashboard as a different user' do
    it 'I can see all of my github followers', :vcr do

      @user2 = create(:user, token: Figaro.env.github_personal_token2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)

      visit '/dashboard'

      within(".github") do
        expect(page).to have_content('User has no followers.')
      end
    end
  end
end
