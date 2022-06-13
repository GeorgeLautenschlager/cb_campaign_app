class AddActivateFlagToCard < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :active, :boolean
  end
end
