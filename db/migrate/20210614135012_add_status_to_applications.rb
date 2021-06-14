class AddStatusToApplications < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE application_status AS ENUM ('on_hold', 'accepted', 'rejected');
    SQL
    add_column :applications, :status, :application_status, default: :on_hold
    add_index :applications, :status
  end

  def down
    remove_column :applications, :status
    execute <<-SQL
      DROP TYPE application_status;
    SQL
  end
end
