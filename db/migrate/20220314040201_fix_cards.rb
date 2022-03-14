class FixCards < ActiveRecord::Migration[7.0]
  def change
     # These attributes are indepenent of campaign state
     add_column :cards, :coalition, :string
     add_column :cards, :airforce, :string
     add_column :cards, :title, :string
     add_column :cards, :mission_description_text, :string
     add_column :cards, :flavour_text, :string
     add_column :cards, :targets, :string
     add_column :cards, :target_values, :string
 
     # These are dependent on map state. but included for completeness
     add_column :cards, :airfield, :string
     add_column :cards, :plane, :string
     add_column :cards, :loadout, :integer
     add_column :cards, :death_percentage, :integer
     add_column :cards, :capture_percentage, :integer
     add_column :cards, :area_of_operation, :string
  end
end
