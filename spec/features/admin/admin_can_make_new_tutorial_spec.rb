require 'rails_helper'

RSpec.describe 'As an Admin' do
        before :each do
        admin = create(:admin)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
     end 
    it 'Can make a new tutorial' do 
        visit new_admin_tutorial_path
        fill_in "tutorial[title]", with: "A New Tutorial"
        fill_in "tutorial[description]", with: "A New description"
        fill_in "tutorial[thumbnail]", with: "https://i.ytimg.com/vi/x3dNNlRxo8U/maxresdefault.jpg"
        fill_in "video[video_id]", with: "https://i.ytimg.com/vi/x3dNNlRxo8U/maxresdefault.jpg"
        fill_in "video[title]", with: "New Video"
        fill_in "video[description]", with: "New description"
        click_on "Save"
        expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")
        expect(page).to have_content("A New Tutorial")
        expect(page).to have_content("Successfully created tutorial.")
    end 
    it 'will see an error if not all info is filled in' do
        visit new_admin_tutorial_path
        fill_in 'tutorial_title', with: "new Tutorial"
        fill_in 'tutorial_thumbnail', with: "http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg"
        click_on "Save"

        expect(page).to have_content("Please fill in all fields. Description can't be blank")
  end
end 