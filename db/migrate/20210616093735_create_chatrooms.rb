class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms, id: :uuid do |t|

      t.timestamps
    end

    add_index :chatrooms, :updated_at
  end
end
