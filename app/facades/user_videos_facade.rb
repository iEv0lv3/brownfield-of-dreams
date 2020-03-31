class UserVideosFacade
  attr_reader :user, :bookmarks, :user_friends

  def initialize(user)
    @user = User.find_by(id: user.id)
    @bookmarks = find_bookmarks
    @user_friends = find_friends
  end

  def find_bookmarks
    @bookmarks = @user.my_bookmarks.reduce(Hash.new([])) do |bm, video|
      bm[video.tutorial_id] += [] << video
      bm
    end
  end

  def find_friends
    @user.friends
  end
end
