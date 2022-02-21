class AddTwitterToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter, :string
    add_index :users, :twitter
  end
end
