require 'rails_helper'

RSpec.describe 'As a guest user', type: :feature do
  describe 'When I visit /' do

    it "I click the 'Register' link and should be on /register" do

      visit '/register'

      fill_in :email, with: 'rick@rolled.com'
      fill_in :first_name, with: 'Rick'
      fill_in :last_name, with: 'Astley'
      fill_in :password, with: '12345'
      fill_in :password_confirmation, with: '12345'

      click_on 'Create Account'

      expect(current_path).to eq(dash_board_path)

      expect(page).to have_content("Rick's Dashboard")
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
  end
end
