require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  before :each do
    @user1 = User.create!(
      first_name: 'Jordan',
      last_name: 'Williams',
      email: 'jordan@mail.com',
      password: 'none',
      github_url: 'https://github.com/iEv0lv3',
      github_token: "#{ Figaro.env.github_personal_token }"
    )

    @user2 = User.create!(
      first_name: 'Pierce',
      last_name: 'Alworth',
      email: 'pierce@mail.com',
      password: 'none',
      github_url: 'https://github.com/palworth',
      github_token: "#{ Figaro.env.github_personal_token2 }"
    )
  end

  describe 'When I visit my dashboard' do
    it 'I can add followers as friends', :vcr do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit dashboard_path

      within("#follower-palworth") do
        click_on 'Add Friend'
      end

      expect(page).to have_content('Added friend.')

      within("#follower-palworth") do
        expect(page).to_not have_link('Add Friend')
      end

      within("#following-palworth") do
        expect(page).to_not have_link('Add Friend')
      end
    end

    it 'I can add anyone I am following as friends', :vcr do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit dashboard_path

      within("#following-palworth") do
        click_on 'Add Friend'
      end

      expect(page).to have_content('Added friend.')

      within("#follower-palworth") do
        expect(page).to_not have_link('Add Friend')
      end

      within("#following-palworth") do
        expect(page).to_not have_link('Add Friend')
      end
    end
  end
end
