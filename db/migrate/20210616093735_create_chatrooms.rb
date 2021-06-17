class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end

    add_index :chatrooms, :user_id, name: 'chatrooms_user_id_idx'
    add_index :chatrooms, :project_id, name: 'chatrooms_project_id_idx'
    add_index :chatrooms, [:user_id, :project_id], unique: true
    add_index :chatrooms, :updated_at
  end
end
