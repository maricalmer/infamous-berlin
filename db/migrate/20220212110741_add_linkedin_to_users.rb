class AddLinkedinToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :linkedin, :string
    add_index :users, :linkedin
  end
end
