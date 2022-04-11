class CreateMirrors < ActiveRecord::Migration[6.0]
  def change
    create_table :mirrors do |t|
      t.string :img_url
      t.string :coordinate_x
      t.string :coordinate_y
      t.string :coordinate_h
      t.string :coordinate_w
      t.references :portfolio, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
