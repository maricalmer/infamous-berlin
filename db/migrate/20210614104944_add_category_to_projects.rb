class AddCategoryToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :category, :string
    add_index :projects, :category
  end
end
