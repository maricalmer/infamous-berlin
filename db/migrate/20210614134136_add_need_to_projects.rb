class AddNeedToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :need, :string, array: true, default: []
  end
end
