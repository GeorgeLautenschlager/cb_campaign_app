class RemovePilotFromCard < ActiveRecord::Migration[7.0]
  def change
    remove_column :cards, :pilot_id
  end
end
