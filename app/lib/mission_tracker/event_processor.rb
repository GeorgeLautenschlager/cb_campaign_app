require 'protobufs/velikie-campaign-day-49-events_pb.rb'

class MissionTracker::EventProcessor
  attr_reader :proto_buff_data

  def initialize(proto_path = nil)
    proto_path ||= 'static_data/day-12/events/velikie-campaign-day-12-events-0000.bin'
    @proto_buff_data = CampaignLibrary::Protobuf::MissionEvents.decode File.open(proto_path, 'rb').read
  end

  def process!
    @proto_buff_data.Events.each do |event|
      process_event event
    end
  end

  private
  def process_event(event)
    case event.subtype
    when :PlayerSpawn
      puts "Processing Player Spawn event for #{event.PlayerSpawn.PlayerName}"
      user = User.find_by callsign: event.PlayerSpawn.PlayerName
      if user.nil?
        puts "No User found for callsign #{event.PlayerSpawn.PlayerName}"
        return
      end

      pilot = load_pilot user, event.PlayerSpawn.Country.Name
      if pilot.nil?
        puts "Error: user #{user.id} has no #{event.PlayerSpawn.Country.Name} pilot"
        return
      else
        puts "Loaded Pilot #{pilot.to_s}"
      end

      mission_track = pilots.cards.active.first.mission_track
      if mission_track.nil?
        put "Pilot #{pilot.to_s} has no activated mission"
        return
      else
        mission_track.update! bot_pilot_id: event.PlayerSpawn.Aircraft.Aircraft.Pilot.Id
        puts "Assigned Bot Pilot ID #{event.PlayerSpawn.Aircraft.Aircraft.Pilot.Id}"
        mission_track.spawn!
      end
    when :Takeoff
      puts "Processing Takeoff event for Bot Pilot ID #{event.Takeoff.Aircraft.Aircraft.Pilot.Id}"

      mission_track = MissionTrack.find_by(bot_pilot_id: event.Takeoff.Aircraft.Aircraft.Pilot.Id)

      if mission_track.nil?
        put "Pilot #{pilot.to_s} has no activated mission"
        return
      end

      mission_track.takeoff!
    when :Kill
      puts "Processing Kill event for Bot Pilot ID #{event.Takeoff.Aircraft.Aircraft.Pilot.Id}"
      mission_track = MissionTrack.find_by(bot_pilot_id: event.Kill.Attacker.Aircraft.Pilot.Id)

      if mission_track.nil?
        put "Pilot #{pilot.to_s} has no activated mission"
        return
      end

      # TODO: Handle Aircraft and Vehicle subtypes
      # TODO: handle multiples and umbrella types like "ground units"
      correct_coalition = coalition(event.Kill.Victim.Country.Name) == mission_track.card.pilot
      correct_target = mission_track.card.targets.include? TARGET_CATEGORIES_MAP[event.Kill.Victim.StaticBlock.Category]

      if correct_coalition && correct_target
        # TODO: one might not always be enough
        mission_track.meet_objective!
      end
    when :Landing
      puts "Processing Landing event for Bot Pilot ID #{event.Takeoff.Aircraft.Aircraft.Pilot.Id}"
      mission_track = MissionTrack.find_by(bot_pilot_id: event.Landing.Aircraft.Aircraft.Pilot.Id)

      if at_home_airfield? card, event.Landing.Position
        Mission_track.success!
      end
    end

    # TODO:
    # - :Spawn
    # - :SortieEnd
    # - :Disconnect
    # - ::Damage
  end

  # TODO: Actually implement this
  def at_home_airfield?(card, position)
    true
  end

  # TODO: this along with other code like MissionCards::DeckGenerator.opposite_coalition
  # should be wrapped in a utility class
  def coalition(country)
    if ['Great Britain', 'United States', 'USSR'].include country
      'allied'
    else
      'axis'
    end
  end
end
