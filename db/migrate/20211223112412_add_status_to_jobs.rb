class AddStatusToJobs < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE job_status AS ENUM ('open', 'close');
    SQL
    add_column :jobs, :status, :job_status, default: :open
    add_index :jobs, :status
  end

  def down
    remove_column :jobs, :status
    execute <<-SQL
      DROP TYPE job_status;
    SQL
  end
end
