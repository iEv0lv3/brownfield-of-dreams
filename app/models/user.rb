require './app/models/github/repo'
require './app/models/github/follower'
require 'securerandom'

class User < ApplicationRecord
  before_create :activation_token

  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name

  enum role: %i[default admin]
  enum activated: ['false', 'true']

  has_secure_password

  def my_repos
    github_service = GithubService.new(self)
    repos = github_service.repo_data
    repos.map do |repo|
      Repo.new(repo)
    end
  end

  def my_followers
    github_service = GithubService.new(self)
    followers = github_service.follower_data
    followers.map do |follower|
      Follower.new(follower)
    end
  end

  def following
    github_service = GithubService.new(self)
    following = github_service.following_data
    following.map do |follower|
      Follower.new(follower)
    end
  end

  def my_bookmarks
    Video.joins(:user_videos)
         .where("user_videos.user_id = #{id}")
         .order(:tutorial_id)
         .order(:position)
  end

  def my_friend?(follower)
    friends.include?(follower.user)
  end

  def add_friend?(follower)
    follower.user.nil? == false && my_friend?(follower) == false
  end

  def create_friendship(friend_param)
    friendship1 = Friendship.new(user_id: id, friend_id: friend_param)
    friendship2 = Friendship.new(user_id: friend_param, friend_id: id)
    'success' if friendship1.save && friendship2.save
  end

  private

  def activation_token
    self.confirm_token = SecureRandom.hex(10) if confirm_token.empty?
  end
end
