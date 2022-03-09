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

  # Instance Methods
  
  # TODO: build a map of loadouts to targets

    # airforce_templates = CardTemplate.where(airforce: @airforce)

    # rename nationality to airforce
    # create airforce
    # load deck config
    # filter cards by: available target

    # phase 1 - get all the templates, populate them at random, truncate cards and repopulate
    # phase 2 - deck size is an attr, templates are filtered by inputs to the DeckGenerator
    # phase 3 - stabilize set of inputs

    # On cards: the "deck" is simply the extant set of Card records for a given air force, a has_and_belongs_to_many relationship
    # and validations in the pilot class is what maintains the illusion of a "hand"

    # Next Actions:
    # - create a bunch of models (barebones is fine for now, you just need the relationships and maybe names (for pilots, airforces, squads, etc.))
    # - DeckGenerator
    # - Dealer
    # - bump version to 3.1.0
  
  def initialize
    @deck_config = YAML.load_file "./static_data/deck_config.yml"
  end

  def deck_limit
    deck_config["size"]
  end

  def actionable_targets(coalition)
    deck_config[coalition]["targets"]
  end

  def actionable_planes(airforce)
    
  end

  def opposing_coalition(coalition)
    coalition == "allies" ? "axis" : "allies"
  end

  def generate!
    [:allies, :axis].each do |coalition|
      actionable_templates_for_coalition = actionable_card_templates coalition
      coalition.airforces.each do |airforce|
        actionable_card_templates.where(airforce: airforce)
        generate_for_airforce!(airforce, actionable_templates_for_coalition)
      end
    end
  end

  private def generate_for_airforce!(airforce, actionable_card_templates)
    actionable_card_templates
    # TODO: handle the three levels of cards: cards that are always in the player's hand, cards that are included regardless of map state
    # and cards that are included if there's a valid target for them. "always_in_hand", "unconditional", "conditional"

    # now, distribute the card limit over the various weights somehow
    # use walker's method for this: https://github.com/cantino/walker_method
    # that gives us a template, and a number of cards to generate from that template
    # generate each card, filling in the AO from the target data, 
    # and the plane and airfield from the airplane data
    # randomize the percentages (0-20) for now
  end

  # TODO: add conditional flag, duration and weight to templates
  # TODO: change nationality to airforce
  private def actionable_card_templates(coalition)
    templates = CardTemplate.where(
      coalition: coalition.to_s,
      targets: deck_config[coalition][:targets]
    ).or(CardTemplate.where(
      coalition: coalition.to_s,
      conditional: false
    ))
  end
end