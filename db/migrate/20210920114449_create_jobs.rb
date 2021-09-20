class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.datetime :deadline
      t.datetime :start_date
      t.datetime :end_date
      t.string :title
      t.string :skills_needed, array: true
      t.text :description
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end

    add_index :jobs, :skills_needed, using: 'gin'
  end
end
