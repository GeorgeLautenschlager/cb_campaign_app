class MissionCards::CardGenerator
  attr_reader :template
  attr_reader :available_planes
  attr_reader :actionable_targets

  def initialize(template, available_planes, actionable_targets)
    @template = template
    @available_planes = available_planes
    @actionable_targets = actionable_targets
  end

  def populate_and_save!
    new_card = Card.new

    # TODO: iterate through all the options of plane and airfield
    plane_config = plane_options.first
    new_card.plane = plane_config["type"]
    new_card.airfield = plane_config["airfields"].first
    
    new_card.death_percentage = 10
    new_card.capture_percentage = 10

    # TODO: Select loadout
    new_card.loadout = 1

    # TODO: select AO
    new_card.area_of_operation = "Gladbach Defences"
  end

  def plane_options
    available_planes.select do |plane_config|
      plane = MissionCards::Plane.new(plane_config["type"])
      
      template.plane.split(',').map(&:strip).any? { |role| plane.send("#{role}?".to_sym) } &&
      plane_config["airfields"].any? { |airfield| airfield["airforce"] == template.airforce}
    end
  end
end