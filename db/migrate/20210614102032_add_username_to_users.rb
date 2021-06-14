class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension :citext
    add_column :users, :username, :citext
    add_index :users, :username, unique: true
  end
end
