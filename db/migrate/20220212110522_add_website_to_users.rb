class AddWebsiteToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :website, :string
    add_index :users, :website
  end
end
