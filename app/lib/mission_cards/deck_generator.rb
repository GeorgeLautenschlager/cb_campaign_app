require 'csv'
require 'yaml'

class MissionCards::DeckGenerator
  attr_reader :deck_config

  # Class Methods
  def self.sync_card_templates!
    card_template_rows = CSV.read './static_data/card_templates.csv'
    # Remove first header row
    card_template_rows.shift

    # Turn the rows into attributes hashes
    hash_keys = card_template_rows.shift.map { |key| key.downcase.parameterize.underscore.to_sym }
    new_card_templates = card_template_rows.map do |row|
      hash_keys.zip(row).to_h
    end

    # Wipe the existing templates and commit the new ones
    ActiveRecord::Base.transaction do
      CardTemplate.delete_all
      CardTemplate.insert_all(new_card_templates)
    end
  end

  def self.opposite_coalition(coalition)
    return "axis" if coalition == "allies"
    "allies"
  end
  
  def initialize
    @deck_config = YAML.load_file './static_data/deck_config.yml'
  end

  def attackable_targets(coalition)
    deck_config[coalition]['targets']
  end

  def defendable_targets(coalition)
    deck_config[self.class.opposite_coalition(coalition)]['targets']
  end

  def available_planes(airforce)
    deck_config[airforce.coalition]['planes'].select do |plane_config|
      plane_config['airfields'].any? do |airfield_config|
        airfield_config['airforce'].downcase == airforce.name.downcase
      end
    end
  end

  def actionable_card_templates(airforce)
    templates = CardTemplate.where(
      airforce: airforce.name,
      targets: attackable_targets(airforce.coalition).map { |target| target['type'] }
    )
  end

  def generate!
    [:allies, :axis].each do |coalition|
      actionable_templates_for_coalition = actionable_card_templates coalition
      coalition.airforces.each do |airforce|
        generate_for_airforce!(airforce)
      end
    end
  end

  def generate_for_airforce!(airforce)
    actionable_card_templates(airforce)

    # Phase 1:
    # Just populate the "deck" with all the actionable templates

    actionable_card_templates.each do |template|
      # card_gen = CardGenerator.new(template, self)
      # card_gen.generate_cards!
    end
  end
end