require 'protobufs/velikie-campaign-day-49-events_pb.rb'

class MissionTracker::EventProcessor
  attr_reader :proto_buff_data

  def initialize
    proto_path = 'static_data/day-49/events/velikie-campaign-day-49-events-0000.bin'
    @proto_buff_data = CampaignLibrary::Protobuf::MissionEvents.decode File.open(proto_path, 'rb').read
  end
end
