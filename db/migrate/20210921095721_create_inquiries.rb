class CreateInquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :inquiries, id: :uuid do |t|
      t.text :experience
      t.text :motivation
      t.references  :job, type: :uuid, null: false, foreign_key: true
      t.references  :user, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
