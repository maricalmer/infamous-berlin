class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :content, null: false
      t.integer :receiver_id, null: false
      t.integer :anchor_id, null: false
      t.boolean :read_by_receiver, default: false
      t.references :chatroom, type: :uuid, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :messages, :receiver_id
    add_index :messages, :anchor_id
    add_index :messages, :chatroom_id, name: 'messages_chatroom_id_idx'
    add_index :messages, :user_id, name: 'messages_user_id_idx'
    add_index :messages, [:user_id, :receiver_id], unique: true
  end
end
