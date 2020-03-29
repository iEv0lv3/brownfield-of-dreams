class UserVideosFacade
  attr_reader :user, :bookmarks

  def initialize(user)
    @user = User.find_by(id: user.id)
    @bookmarks = nil
  end

  def find_bookmarks
    @bookmarks = @user.my_bookmarks.reduce(Hash.new([])) do |bm, video|
      bm[video.tutorial_id] += [] << video
      bm
    end
  end
end
