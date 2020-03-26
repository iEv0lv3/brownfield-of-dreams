class GithubService
  def initialize(token)
    @token = token
    # I want to create a universal api connection. Headers are the issue here.

    # @connection = Faraday.new(
    #   url: "https://api.github.com/user",
    #   headers: { 'Accept': 'application/vnd.github.v3+json',
    #              'Authorization': "access_token #{@token}"
    #   }
    # )
  end

  def repos
    repo_response = Faraday.get("https://api.github.com/user/repos?access_token=#{@token}")
    repo_body = JSON.parse(repo_response.body, symbolize_names: true)
    repo_body[1..5]
  end

  def followers
    followers_response = Faraday.get("https://api.github.com/user/followers?access_token=#{@token}")
    JSON.parse(followers_response.body, symbolize_names: true)
  end

  def following
    following_response = Faraday.get("https://api.github.com/user/following?access_token=#{@token}")
    JSON.parse(following_response.body, symbolize_names: true)
  end
end
