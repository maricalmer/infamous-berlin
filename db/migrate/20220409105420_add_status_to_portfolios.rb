class AddStatusToPortfolios < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE portfolio_status AS ENUM ('past', 'upcoming');
    SQL
    add_column :portfolios, :status, :portfolio_status, default: :past
    add_index :portfolios, :status
  end

  def down
    remove_column :portfolios, :status
    execute <<-SQL
      DROP TYPE portfolio_status;
    SQL
  end
end
