class MissionCards::CardGenerator
  attr_reader :template, :available_planes, :actionable_targets

  def initialize(template, available_planes, actionable_targets)
    @template = template
    @available_planes = available_planes
    @actionable_targets = actionable_targets
  end

  def generate_cards!
    new_cards = []
    plane_options.each do |plane_option|
      areas_of_operation.each do |area_of_operation|
        plane_option["airfields"].each do |airfield|
          attrs = {
            plane: plane_option["type"],
            airfield: airfield["name"],
            death_percentage: 10,
            capture_percentage: 10,
            loadout: 1,
            area_of_operation: area_of_operation,
            card_template: template
          }.merge(template.attributes.slice(
            "coalition",
            "airforce",
            "title",
            "mission_description_text",
            "flavour_text",
            "targets",
            "target_values"
          ))
          
          new_cards << Card.create!(attrs)
        end
      end
    end

    new_cards
  end

  def plane_options
    available_planes.select do |plane_config|
      plane = MissionCards::Plane.new(plane_config["type"])
      
      template.plane.split(',').map(&:strip).any? { |role| plane.send("#{role}?".to_sym) } &&
      plane_config["airfields"].any? { |airfield| airfield["airforce"] == template.airforce}
    end
  end

  def areas_of_operation
    if template.targets == "fighters"
      actionable_targets.map {|target_config| target_config["areas_of_operation"]}
    elsif template.targets == "bombers" || template.targets == "attackers"
      # TODO: get friendly targets
      []
    else
      actionable_targets.select do |target_config|
        template.targets.include? target_config["type"]
      end.map {|target_config| target_config["areas_of_operation"]}
    end.flatten.uniq
  end
end