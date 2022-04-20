class CreateMirrors < ActiveRecord::Migration[6.0]
  def change
    create_table :mirrors do |t|
      t.string :img_key
      t.string :grid_x
      t.string :grid_y
      t.string :grid_h
      t.string :grid_w
      t.string :crop_x
      t.string :crop_y
      t.string :crop_h
      t.string :crop_w
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
