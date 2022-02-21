class AddMixcloudToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mixcloud, :string
    add_index :users, :mixcloud
  end
end
