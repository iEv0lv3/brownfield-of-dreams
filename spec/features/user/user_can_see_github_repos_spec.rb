require 'rails_helper'

RSpec.describe 'As a user', type: :feature do

  describe 'When I view my dashboard' do
    vcr_options = { :record => :new_episodes }
    it 'I can see 5 of my GitHub repos listed', :js, :vcr => vcr_options do

      @user = create(:user, token: Figaro.env.github_personal_token)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/dashboard'

      within(".github") do
        expect(page).to have_link('activerecord-obstacle-course')
        expect(page).to have_link('adopt_dont_shop')
        expect(page).to have_link('algorithm_sort')
        expect(page).to have_link('b2-mid-mod')
        expect(page).to have_link('backend_module_0_capstone')
      end
    end
  end

  describe 'When I view my dashboard as a different user' do
    vcr_options = { :record => :new_episodes }
    it 'I can see 5 of my Github repos', :js, :vcr => vcr_options do

      @user2 = create(:user, token: Figaro.env.github_personal_token2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)

      visit '/dashboard'

      within(".github") do
        expect(page).to have_link('monster_shop_1911')
        expect(page).to have_link('battleship')
        expect(page).to have_link('git_for_pairs_practice')
        expect(page).to have_link('adopt_dont_shop')
        expect(page).to have_link('b2-mid-mod')
      end
    end
  end
end
