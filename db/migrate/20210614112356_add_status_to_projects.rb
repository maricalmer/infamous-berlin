class AddStatusToProjects < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE project_status AS ENUM ('portfolio', 'upcoming', 'deleted');
    SQL
    add_column :projects, :status, :project_status, default: :portfolio
    add_index :projects, :status
  end

  def down
    remove_column :projects, :status
    execute <<-SQL
      DROP TYPE project_status;
    SQL
  end
end
