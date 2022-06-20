class CreateMissionTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :mission_tracks do |t|
      t.integer :card_id
      t.integer :bot_pilot_id
      t.string :aasm_state

      t.timestamps
    end

    add_index :mission_tracks, :bot_pilot_id
  end
end
