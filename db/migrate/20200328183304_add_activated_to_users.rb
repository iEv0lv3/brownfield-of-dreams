class AddActivatedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activated, :integer, default: 0
    add_column :users, :confirm_token, :string, default: ''
  end
end
