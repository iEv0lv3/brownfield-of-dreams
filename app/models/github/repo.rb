class Repo
  attr_reader :name, :url, :id

  def initialize(data = Hash.new)
    @name = data[:name]
    @url = data[:html_url]
    @id = data[:id]
  end
end
