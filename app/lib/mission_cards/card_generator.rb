class MissionCards::CardGenerator
  attr_reader :template, :available_planes, :attackable_targets, :defendable_targets

  def initialize(template, deck_generator)
    @template = template

    airforce = Airforce.find_by(name: template.airforce)
    @available_planes = deck_generator.available_planes(airforce)
    @attackable_targets = deck_generator.attackable_targets(airforce.coalition)
    @defendable_targets = deck_generator.defendable_targets(airforce.coalition)
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
      template.plane.present? &&
        template.plane.split(',').map(&:strip).any? { |role| plane.send("#{role}?".to_sym) } ||
        template.plane.nil? &&
        plane_config["airfields"].any? { |airfield| airfield["airforce"] == template.airforce}
    end
  end

  def areas_of_operation
    if template.targets == "fighters"
      attackable_targets.map {|target_config| target_config["areas_of_operation"]}
    elsif template.targets == "bombers" || template.targets == "attackers" || template.defend == 'all ground targets'
      defendable_targets.map {|target_config| target_config["areas_of_operation"]}
    elsif template.defend.present?
      defendable_targets.select do |target_config|
        template.defend.include? target_config["type"]
      end.map {|target_config| target_config["areas_of_operation"]} 
    else
      attackable_targets.select do |target_config|
        template.targets.include? target_config["type"]
      end.map {|target_config| target_config["areas_of_operation"]}
    end.flatten.uniq
  end
end