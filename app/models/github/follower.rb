class Follower
  attr_reader :name, :url, :id

  def initialize(data = Hash.new)
    @name = data[:login]
    @url = data[:html_url]
    @id = data[:id]
  end
end
