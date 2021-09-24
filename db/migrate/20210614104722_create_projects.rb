class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :projects, :title, unique: true
    add_index :projects, :description
    add_index :projects, :location
  end
end
