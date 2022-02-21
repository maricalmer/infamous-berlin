class AddPaymentToJobs < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE job_payment AS ENUM ('hourly_rate', 'fixed_rate');
    SQL
    add_column :jobs, :payment, :job_payment, default: :fixed_rate
    add_index :jobs, :payment
  end

  def down
    remove_column :jobs, :payment
    execute <<-SQL
      DROP TYPE job_payment;
    SQL
  end
end
