require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  before :each do
    user2 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    tutorials = create_list(:tutorial, 3)

    @tutorial1 = tutorials[0]
    @tutorial2 = tutorials[1]
    @tutorial3 = tutorials[2]

    create(:video, tutorial: @tutorial1, position: 0)
    create(:video, tutorial: @tutorial1, position: 1)
    create(:video, tutorial: @tutorial1, position: 2)

    create(:video, tutorial: @tutorial2, position: 0)
    create(:video, tutorial: @tutorial2, position: 1)
    create(:video, tutorial: @tutorial2, position: 2)

    create(:video, tutorial: @tutorial3, position: 0)
    create(:video, tutorial: @tutorial3, position: 1)
    create(:video, tutorial: @tutorial3, position: 2)

    visit tutorial_path(@tutorial1)

    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_on @tutorial1.videos[1].title
    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')

    visit tutorial_path(@tutorial2)

    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_on @tutorial2.videos[1].title
    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')

    visit tutorial_path(@tutorial3)

    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_on @tutorial3.videos[1].title
    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
  end

  describe 'When I visit my dashboard, my bookmarks are organized' do
    it 'by tutorial' do
      user1 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit tutorial_path(@tutorial1)

      click_on 'Bookmark'
      expect(page).to have_content('Bookmark added to your dashboard')
      click_on @tutorial1.videos[1].title
      click_on 'Bookmark'
      expect(page).to have_content('Bookmark added to your dashboard')

      visit tutorial_path(@tutorial2)

      click_on 'Bookmark'
      expect(page).to have_content('Bookmark added to your dashboard')
      click_on @tutorial2.videos[1].title
      click_on 'Bookmark'
      expect(page).to have_content('Bookmark added to your dashboard')

      visit tutorial_path(@tutorial3)

      click_on 'Bookmark'
      expect(page).to have_content('Bookmark added to your dashboard')
      click_on @tutorial3.videos[1].title
      click_on 'Bookmark'
      expect(page).to have_content('Bookmark added to your dashboard')

      visit dashboard_path

      within("#tutorial-#{@tutorial1.id}") do
        expect(page).to have_content(@tutorial1.title)
        expect(page).to have_content(@tutorial1.videos[0].title)
        expect(page).to have_content(@tutorial1.videos[1].title)
      end

      within("#tutorial-#{@tutorial2.id}") do
        expect(page).to have_content(@tutorial2.title)
        expect(page).to have_content(@tutorial2.videos[0].title)
        expect(page).to have_content(@tutorial2.videos[1].title)
      end

      within("#tutorial-#{@tutorial3.id}") do
        expect(page).to have_content(@tutorial3.title)
        expect(page).to have_content(@tutorial3.videos[0].title)
        expect(page).to have_content(@tutorial3.videos[1].title)
      end
    end
  end
end
