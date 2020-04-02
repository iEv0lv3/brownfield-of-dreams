require 'rails_helper'

RSpec.describe 'As a guest user', type: :feature do
  describe 'When I visit /' do
    it "I click the 'Register' link and should be on /register" do
      visit '/'

      click_on 'Register'

      expect(current_path).to eq(register_path)

      fill_in 'user[email]', with: 'rick@rolled.com'
      fill_in 'user[first_name]', with: 'Rick'
      fill_in 'user[last_name]', with: 'Astley'
      fill_in 'user[password]', with: '12345'
      fill_in 'user[password_confirmation]', with: '12345'

      click_on 'Create Account'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Rick's Dashboard")
      expect(page).to have_content('This account has not yet been activated. Please check your email.')

      user = User.last

      visit "/users/activate?confirm=#{user.confirm_token}"

      expect(page).to have_content("Thank you! Your account is now activated #{user.first_name}.")
      expect(page).to have_link("#{user.first_name}'s Dashboard")

      activation = spy(AccountActivationMailer.inform(user, 'http://localhost:3000/users'))
      activation.deliver
      expect(activation).to have_received(:deliver)
    end
  end

  describe 'Account activation sad path' do
    it "Can't activate if token doesn't exist" do
      visit '/'

      click_on 'Register'

      expect(current_path).to eq(register_path)

      fill_in 'user[email]', with: 'rick@rolled.com'
      fill_in 'user[first_name]', with: 'Rick'
      fill_in 'user[last_name]', with: 'Astley'
      fill_in 'user[password]', with: '12345'
      fill_in 'user[password_confirmation]', with: '12345'

      click_on 'Create Account'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Rick's Dashboard")
      expect(page).to have_content('This account has not yet been activated. Please check your email.')

      user = User.last
      user.confirm_token = ''

      visit "/users/activate?confirm=#{user.confirm_token}"

      expect(page).to have_content('Sorry, activation token does not exist')
    end
  end
end
