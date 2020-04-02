require 'rails_helper'

describe 'Application controller actions', type: :feature do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'controller tests' do
    it '404' do
      visit '/admin/dashboard'

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
