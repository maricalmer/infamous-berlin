class AddYoutubeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :youtube, :string
    add_index :users, :youtube
  end
end
