class AddInclusionToCardTemplate < ActiveRecord::Migration[7.0]
  def change
    add_column :card_templates, :always_in_hand, :string
    add_column :card_templates, :weight, :integer
  end
end
