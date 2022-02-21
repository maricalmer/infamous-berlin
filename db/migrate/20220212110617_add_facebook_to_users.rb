class AddFacebookToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :facebook, :string
    add_index :users, :facebook
  end
end
