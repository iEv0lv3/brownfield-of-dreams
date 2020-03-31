class GithubService
  def initialize(user)
    @user = user
  end

  def repo_data
    repos = get_json("/user/repos")
    repos[1..5]
  end

  def follower_data
    get_json("/user/followers")
  end

  def following_data
    get_json("/user/following")
  end

  private

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: "https://api.github.com") do |f|
        f.headers["Authorization"] = "token #{@user.github_token}"
      end
    end
end
