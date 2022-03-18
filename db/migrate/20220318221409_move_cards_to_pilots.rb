class MoveCardsToPilots < ActiveRecord::Migration[7.0]
  def change
    rename_column :cards, :user_id, :pilot_id
  end
end
