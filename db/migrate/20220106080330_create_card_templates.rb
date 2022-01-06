class CreateCardTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :card_templates do |t|
      t.string :description
      t.string :details
      t.string :category

      t.timestamps
    end
  end
end
