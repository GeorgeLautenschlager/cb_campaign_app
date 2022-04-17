class CardsPilots < ActiveRecord::Migration[7.0]
  def change
    create_table :cards_pilots, id: false do |t|
      t.bigint :card_id
      t.bigint :pilot_id
    end

    add_index :cards_pilots, :card_id
    add_index :cards_pilots, :pilot_id
  end
end
