class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms, id: :uuid do |t|
      t.integer :author_id, null: false
      t.integer :receiver_id, null: false

      t.timestamps
    end

    add_index :chatrooms, :updated_at
    add_index :chatrooms, :author_id
    add_index :chatrooms, :receiver_id
    add_index :chatrooms, [:author_id, :receiver_id], unique: true
  end
end
