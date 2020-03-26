class GithubService
  def initialize(token)
    @token = token
  end

  def repos
    repo_response = Faraday.get("https://api.github.com/user/repos?access_token=#{@token}")
    repo_body = JSON.parse(repo_response.body, symbolize_names: true)
    repo_body[1..5]
  end
end
