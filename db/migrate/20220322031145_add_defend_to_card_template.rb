class AddDefendToCardTemplate < ActiveRecord::Migration[7.0]
  def change
    add_column :card_templates, :defend, :string
  end
end
