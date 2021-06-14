class AddDateToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :date, :datetime
  end
end
