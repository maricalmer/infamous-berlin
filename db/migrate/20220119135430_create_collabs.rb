class CreateCollabs < ActiveRecord::Migration[6.0]
  def change
    create_table :collabs do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false

      t.timestamps
    end
  end
end
