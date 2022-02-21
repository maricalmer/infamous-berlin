class AddInstagramToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :instagram, :string
    add_index :users, :instagram
  end
end
