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

  enum role: [:default, :admin]
  enum activated: ['false', 'true']

  has_secure_password

  def my_repos
    github_service = GithubService.new(self.github_token)
    repos = github_service.repos
    repos.map do |repo|
      Repo.new(repo)
    end
  end

  def my_followers
    github_service = GithubService.new(self.github_token)
    followers = github_service.followers
    followers.map do |follower|
      Follower.new(follower)
    end
  end

  def following
    github_service = GithubService.new(self.github_token)
    following = github_service.following
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
    if friendship1.save && friendship2.save
      'success'
    end
  end

  private

  def activation_token
    if confirm_token.empty?
      self.confirm_token = SecureRandom.hex(10)
    end
  end
end
