require 'protobufs/velikie-campaign_pb.rb'

class MissionCards::DeckConfiguration
  attr_reader :attackable_targets, :defendable_targets, :available_planes
  PROTO_PATH = 'static_data/day-01/velikie-campaign.state'

  def initialize
    @proto_buff_data = CampaignLibrary::Protobuf::CampaignState.decode File.read(PROTO_PATH)

    allied_objectives = @proto_buff_data.Objectives.select do |objective|
      ["United States", "Great Britain"].include? objective.Country.Name
    end

    axis_objectives = @proto_buff_data.Objectives.select do |objective|
      ["Germany"].include? objective.Country.Name
    end

    axis_targets = Hash.new { |h, k| h[k] = [] }
    allied_objectives.each do |objective|
      objective.CampaignObjective.Blocks.map do |block|
        axis_targets[block.Category] << objective.Name
      end
    end
    axis_targets.transform_values! do |ao_list|
      ao_list.uniq
    end

    allied_targets = Hash.new { |h, k| h[k] = [] }
    axis_objectives.each do |objective|
      objective.CampaignObjective.Blocks.map do |block|
        allied_targets[block.Category] << objective.Name
      end
    end
    allied_targets.transform_values! do |ao_list|
      ao_list.uniq
    end
    # TODO: loadouts
    allied_airframes = Hash.new { |h, k| h[k] = [] }
    @proto_buff_data.Airfields.select do |objective|
      ["United States", "Great Britain"].include? objective.Country.Name
    end.each do |airfield|
      airfield.CampaignAirfield.AvailableAirframes.each do |airframe|
        allied_airframes[airframe.Model.split('\\').last] << airfield.Name
      end
    end
    allied_airframes.transform_values! do |airfield_list|
      airfield_list.uniq
    end

    axis_airframes = Hash.new { |h, k| h[k] = [] }
    @proto_buff_data.Airfields.select do |objective|
      ["Germany"].include? objective.Country.Name
    end.each do |airfield|
      airfield.CampaignAirfield.AvailableAirframes.each do |airframe|
        axis_airframes[airframe.Model.split('\\').last.split('.').first] << airfield.Name
      end
    end
    axis_airframes.transform_values! do |airfield_list|
      airfield_list.uniq
    end

    binding.pry
  end
end