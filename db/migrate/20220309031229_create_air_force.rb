class CreateAirForce < ActiveRecord::Migration[7.0]
  def change
    create_table :airforces do |t|
      t.string :name
      t.string :nationality

      t.timestamps
    end

    create_join_table :airforces, :card_templates
  end
end
