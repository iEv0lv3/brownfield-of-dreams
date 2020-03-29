class UpdateUsersTokenToGithubToken < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :token, :github_token
  end
end
