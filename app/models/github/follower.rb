class Follower
  attr_reader :name, :url, :id

  def initialize(data = Hash.new)
    @user_name = data[:login]
    @url = data[:url]
    @id = data[:id]
  end
end
