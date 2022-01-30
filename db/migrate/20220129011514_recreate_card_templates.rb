class RecreateCardTemplates < ActiveRecord::Migration[7.0]
  def change
    # dump old columns from an earlier design
    remove_column :card_templates, :category, :string
    remove_column :card_templates, :description, :string
    remove_column :card_templates, :details, :string

    # These attributes are indepenent of campaign state
    add_column :card_templates, :coalition, :string
    add_column :card_templates, :nationality, :string
    add_column :card_templates, :title, :string
    add_column :card_templates, :mission_description_text, :string
    add_column :card_templates, :flavour_text, :string
    add_column :card_templates, :targets, :string
    add_column :card_templates, :target_values, :string

    # These are dependent on map state. but included for completeness
    add_column :card_templates, :airfield, :string
    add_column :card_templates, :plane, :string
    add_column :card_templates, :loadout, :integer
    add_column :card_templates, :death_percentage, :integer
    add_column :card_templates, :capture_percentage, :integer
    add_column :card_templates, :area_of_operation, :string
  end
end
