class Follower
  attr_reader :name, :url, :id, :user

  def initialize(data = Hash.new)
    @name = data[:login]
    @url = data[:html_url]
    @id = data[:id]
    @user = local_user
  end

  def local_user
    User.find_by(github_url: @url)
  end
end
