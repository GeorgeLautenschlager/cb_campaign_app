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
  
  # TODO: clean this up
  # phase 1 - get all the templates, populate them at random, truncate cards and repopulate
  # phase 2 - deck size is an attr, templates are filtered by inputs to the DeckGenerator
  # phase 3 - stabilize set of inputs

  # On cards: the 'deck' is simply the extant set of Card records for a given air force, a has_and_belongs_to_many relationship
  # and validations in the pilot class is what maintains the illusion of a 'hand'

  # Next Actions:
  # - create a bunch of models (barebones is fine for now, you just need the relationships and maybe names (for pilots, airforces, squads, etc.))
  # - DeckGenerator
  # - Dealer
  # - bump version to 3.1.0
  
  def initialize
    @deck_config = YAML.load_file './static_data/deck_config.yml'
  end

  def deck_limit
    deck_config['size']
  end

  def actionable_targets(coalition)
    deck_config[coalition]['targets'].map { |target| target['type'] }
  end

  def available_planes(airforce)
    deck_config[airforce.coalition]['planes'].select do |plane_config|
      plane_config['airfields'].any? do |airfield_config|
        airfield_config['airforce'].downcase == airforce.name.downcase
      end
    end
  end

  # TODO: add conditional flag, duration and weight to templates
  # TODO: change nationality to airforce
  def actionable_card_templates(airforce)
    templates = CardTemplate.where(
      airforce: airforce.name,
      targets: actionable_targets(airforce.coalition)
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
      create_card!(template)
    end
  end

  # TODO: maybe this should get farmed out into it's own deal
  def create_card!(template)
    # TODO: consider a more elaborate data structure, one that maps config elements to templates
    # this would save the effort of looking things up again.

    # ********** START HERE  **********
    # Even better, maybe walk the deck config and generate as you go.
    deck_config["allies"]['targets'].each do |target|
      # create a card for this target
      # This might fall apart here, because I still may need to do a bunch of iteration to cross reference
      # this created cards with the available planes/airfields
      # maybe extending the deck config will help?
    end 

    # find available planes that match this template. Create cards for each combination
    # of plane, airfield and AO
    
    Card.create(card_template: template)
  end
end