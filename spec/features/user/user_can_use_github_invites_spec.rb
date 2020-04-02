require 'rails_helper'

RSpec.describe 'User Invite Github', type: :feature do
  before :each do
    user = User.create!(
      email: 'kl@mail.com',
      first_name: 'Kendrick',
      last_name: 'Lamar',
      password: 'none',
      role: :default,
      activated: 1,
      confirm_token: Faker::Crypto.md5,
      github_token: ENV['github_personal_token2'],
      github_url: 'https://github.com/palworth'
    )
    user2 = User.create!(
      email: 'cg@mail.com',
      first_name: 'Childish',
      last_name: 'Gambino',
      password: 'none',
      role: :default,
      activated: 1,
      confirm_token: Faker::Crypto.md5,
      github_token: Figaro.env.github_personal_token.to_s,
      github_url: 'https://github.com/iEv0lv3'
    )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'Can send invite thru a form to github users', :vcr do
    visit dashboard_path

    click_on 'Invite Friends'

    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: 'iEv0lv3'
    click_on 'Send Invite'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')
  end
end
