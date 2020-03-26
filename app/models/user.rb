require './app/models/github/repo'
require './app/models/github/follower'

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

  def my_followers
    github_service = GithubService.new(self.token)
    followers = github_service.followers
    followers.map do |follower|
      Follower.new(follower)
    end
  end

  def following
    github_service = GithubService.new(self.token)
    following = github_service.following
    following.map do |follower|
      Follower.new(follower)
    end
  end
end
