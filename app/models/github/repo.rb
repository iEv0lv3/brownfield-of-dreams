class Repo
  attr_reader :name, :url, :id

  def initialize(data = {})
    @name = data[:name]
    @url = data[:html_url]
    @id = data[:id]
  end
end
