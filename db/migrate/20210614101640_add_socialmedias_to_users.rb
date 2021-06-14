class AddSocialmediasToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :socialmedias, :string, array: true, default: []
  end
end
