class MissionCards::CardGenerator
  attr_reader :template, :available_planes, :attackable_targets, :defendable_targets, :airforce

  def initialize(template, deck_generator)
    @template = template

    @airforce = Airforce.find_by(name: template.airforce)
    @available_planes = deck_generator.available_planes(airforce)
    @attackable_targets = deck_generator.attackable_targets(airforce.coalition)
    @defendable_targets = deck_generator.defendable_targets(airforce.coalition)
  end

  def generate_cards!
    new_cards = []
    plane_options.each do |airframe, airfields|
      areas_of_operation.each do |area_of_operation|
        airfields.each do |airfield|
          attrs = {
            plane: airframe,
            airfield: airfield,
            death_percentage: 10,
            capture_percentage: 10,
            loadout: 1,
            area_of_operation: area_of_operation,
            card_template: template,
            mission_description_text: template.attributes["mission_description_text"].gsub(/<AO>/, area_of_operation),
            airforce: @airforce.name,
          }.merge(template.attributes.slice(
            "coalition",
            "airforce",
            "title",
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
    available_planes.select do |airframe, airfields|
      plane = MissionCards::Plane.new(airframe)

      template.plane.present? &&
        template.plane.split(',').map(&:strip).any? { |role| plane.send("#{role}?".to_sym) } ||
        template.plane.nil?
    end
  end

  def areas_of_operation
    if template.targets == "fighters"
      attackable_targets.values
    elsif template.targets == "bombers" || template.targets == "attackers" || template.defend == 'all ground targets'
      defendable_targets.values
    elsif template.defend.present?
      # TODO: targets needs to be an array
      if template.targets.is_a? Array
        template.targets.map do |target_type|
          defendable_targets[target_type]
        end.compact
      else
        attackable_targets[template.targets]
      end
    else
      # TODO: targets needs to be an array
      if template.targets.is_a? Array
        template.targets.map do |target_type|
          attackable_targets[target_type]
        end.flatten.compact.uniq
      else
        attackable_targets[template.targets]
      end
    end.flatten.uniq
  end
end