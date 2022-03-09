require 'csv'

class MissionCards::DeckGenerator

  # Class Methods
  def self.sync_card_templates!
    # TODO: write some tests for this
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

  # def initialize(airforce)
  #   @airforce = airforce
  # end

  # Instance Methods
  def generate!
    "I'll do it this afternoon!"

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
  end
end