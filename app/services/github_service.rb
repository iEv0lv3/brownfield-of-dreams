class GithubService
  def initialize(token)
    @token = token

    # This connection wants 2 arguments, not 3.

    # @connection = Faraday.new(
    #   "https://api.github.com/user",
    #   nil,
    #   { 'Accept': 'application/vnd.github.v3+json', 'Authorization': "token #{@token}" }
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
