require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When I view my dashboard', :vcr do
    it 'I can see 5 of my GitHub repos listed' do
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
end
