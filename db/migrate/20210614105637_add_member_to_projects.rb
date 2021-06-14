class AddMemberToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :member, :string, array: true, default: []
  end
end
