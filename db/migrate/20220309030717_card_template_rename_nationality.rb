class CardTemplateRenameNationality < ActiveRecord::Migration[7.0]
  def change
    rename_column :card_templates, :nationality, :airforce
  end
end
