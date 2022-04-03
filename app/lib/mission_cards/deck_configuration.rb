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

    axis_targets = allied_objectives.map do |objective|
      objective.CampaignObjective.Blocks.map do |block|
        { block.Category => objective.Name }
      end
    end.flatten.uniq

    allied_targets = axis_objectives.map do |objective|
      objective.CampaignObjective.Blocks.map do |block|
        { block.Category => objective.Name }
      end
    end.flatten.uniq

    allied_airframes = @proto_buff_data.Airfields.select do |objective|
      ["United States", "Great Britain"].include? objective.Country.Name
    end.map do |airfield|
      { airfield.CampaignAirfield.AvailableAirframes.map(&:Model) => airfield.Name }
    end.flatten.uniq

    axis_airframes = @proto_buff_data.Airfields.select do |objective|
      ["Germany"].include? objective.Country.Name
    end.map do |airfield|
      { airfield.CampaignAirfield.AvailableAirframes.map(&:Model) => airfield.Name }
    end.flatten.uniq

    binding.pry

    # TODO:
    # - merge the above key value pairs into hashes
    # - don't forget about loadouts, maybe compile a list of whole protobuf objects
  end
end