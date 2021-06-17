class AddStatusToApplies < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE apply_status AS ENUM ('on_hold', 'accepted', 'rejected');
    SQL
    add_column :applies, :status, :apply_status, default: :on_hold
    add_index :applies, :status
  end

  def down
    remove_column :applies, :status
    execute <<-SQL
      DROP TYPE apply_status;
    SQL
  end
end
