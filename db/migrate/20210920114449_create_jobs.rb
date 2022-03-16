class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :title
      t.string :location
      t.integer :money
      t.string :skills_needed
      t.text :description
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end

    add_index :jobs, :skills_needed
  end
end
