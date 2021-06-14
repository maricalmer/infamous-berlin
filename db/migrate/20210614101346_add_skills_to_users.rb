class AddSkillsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :skills, :string, array: true, default: []
  end
end
