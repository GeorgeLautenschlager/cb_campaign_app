require 'protobufs/CampaignState_pb.rb'

class MissionCards::DeckConfiguration
  attr_reader :attackable_targets, :defendable_targets, :available_planes
  PROTO_PATH = 'static_data/day_03.state'

  def initialize
    @proto_buff_data = CampaignState.decode File.read(PROTO_PATH)

    allied_objectives = @proto_buff_data.Objectives.select do |objective|
      ["United States", "Great Britain"].include? objective.Country.Name
    end

    axis_objectives = @proto_buff_data.Objectives.select do |objective|
      ["United Germany"].include? objective.Country.Name
    end

    binding.pry
  end
end