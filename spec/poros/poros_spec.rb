require 'rails_helper'
require './app/models/github/follower'
require './app/models/github/repo'

describe 'Poros' do
  it 'follower' do
    data = {
      login: 'iEv0lv3',
      html_url: 'https://github.com/iEv0lv3',
      id: '12345'
    }
    follower = Follower.new(data)
    expect(follower.name).to eq('iEv0lv3')
    expect(follower.url).to eq('https://github.com/iEv0lv3')
    expect(follower.id).to eq('12345')
  end

  it 'repo' do
    data = {
      name: 'iEv0lv3',
      html_url: 'https://github.com/iEv0lv3',
      id: '12345'
    }
    repo = Repo.new(data)
    expect(repo.name).to eq('iEv0lv3')
    expect(repo.url).to eq('https://github.com/iEv0lv3')
    expect(repo.id).to eq('12345')
  end
end
