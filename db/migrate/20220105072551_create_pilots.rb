class CreatePilots < ActiveRecord::Migration[7.0]
  def change
    create_table :pilots do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id
      t.string :type

      t.timestamps
      t.index :user_id
    end
  end
end
