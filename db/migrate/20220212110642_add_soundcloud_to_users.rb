class AddSoundcloudToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :soundcloud, :string
    add_index :users, :soundcloud
  end
end
