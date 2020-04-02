require 'rails_helper'

RSpec.describe 'API admin base controller' do
  before :each do
    @user1 = User.create!(
      first_name: 'Jordan',
      last_name: 'Williams',
      email: 'jordan@mail.com',
      password: 'none',
      role: 'admin',
      github_url: 'https://github.com/iEv0lv3',
      github_token: "#{ Figaro.env.github_personal_token }"
    )

    @user2 = User.create!(
      first_name: 'Pierce',
      last_name: 'Alworth',
      email: 'pierce@mail.com',
      password: 'none',
      role: 'default',
      github_url: 'https://github.com/palworth',
      github_token: "#{ Figaro.env.github_personal_token2 }"
    )
  end

  describe 'Admin can accesses API' do
    it 'Admin requests tutorials index' do
      user3 = create(:user, role: :admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user3)

      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      put admin_api_v1_path(tutorial1)
    end
  end
end
