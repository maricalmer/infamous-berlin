class AddTextToApplies < ActiveRecord::Migration[6.0]
  def change
    add_column :applies, :text, :text
  end
end
