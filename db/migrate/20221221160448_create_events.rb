class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :venue
      t.string :address
      t.datetime :date
      t.string :organizer
      t.string :genre
      t.integer :attendees, array: true, default: []
      t.text :description
      t.text :media
      t.string :slug

      t.timestamps
    end
  end
end
