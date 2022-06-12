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

  def self.build
    MissionCards::DeckGenerator.new(MissionCards::DeckConfiguration.new)
  end

  def self.opposite_coalition(coalition)
    return "axis" if coalition == "allied"
    "allied"
  end

  def initialize(deck_config)
    # @deck_config = YAML.load_file './static_data/deck_config.yml'
    @deck_config = deck_config
  end

  def attackable_targets(coalition)
    deck_config.send("#{coalition}_targets")
  end

  def defendable_targets(coalition)
    deck_config.send("#{self.class.opposite_coalition(coalition)}_targets")
  end

  def available_planes(airforce)
    deck_config.send("#{airforce.coalition}_airframes")[airforce.name.downcase.to_sym]
  end

  def actionable_card_templates(airforce)
    templates = CardTemplate.where(
      airforce: airforce.name
    )
  end

  def generate!
    Card.destroy_all

    Airforce.all.map do |airforce|
      generate_for_airforce!(airforce)
    end.flatten
  end

  def generate_for_airforce!(airforce)
    actionable_card_templates(airforce).map do |template|
      card_gen = MissionCards::CardGenerator.new(template, self)
      card_gen.generate_cards!
    end.flatten
  end
end
