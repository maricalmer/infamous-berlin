class AddStatusToInquiries < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE inquiry_status AS ENUM ('on_hold', 'accepted', 'rejected');
    SQL
    add_column :inquiries, :status, :inquiry_status, default: :on_hold
    add_index :inquiries, :status
  end

  def down
    remove_column :inquiries, :status
    execute <<-SQL
      DROP TYPE inquiry_status;
    SQL
  end
end
