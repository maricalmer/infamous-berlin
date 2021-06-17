class CreateApplies < ActiveRecord::Migration[6.0]
  def change
    create_table :applies do |t|
      t.integer 'applying_id', null: false
      t.integer 'applicant_id', null: false

      t.timestamps null: false
    end

    add_index :applies, :applying_id
    add_index :applies, :applicant_id
    add_index :applies, [:applying_id, :applicant_id], unique: true
  end
end
