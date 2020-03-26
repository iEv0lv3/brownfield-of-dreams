require './app/models/github/repo'

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def my_repos
    github_service = GithubService.new(self.token)
    repos = github_service.repos
    repos.map do |repo|
      Repo.new(repo)
    end
  end
end
