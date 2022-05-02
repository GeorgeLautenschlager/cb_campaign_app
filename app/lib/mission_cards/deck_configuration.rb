require 'protobufs/velikie-campaign_pb.rb'

class MissionCards::DeckConfiguration
  attr_reader :allied_objectives, :axis_objectives, :allied_targets, :axis_targets, :allied_airframes, :axis_airframes

  TARGET_CATEGORIES_MAP = {
    'coastal' => ["coastal logistics"],
    'bridge' => ["bridges"],
    'railcar_static' => ["trains"],
    'ship_static' => ["ships"],
    'encampment' => ["bases"],
    'v1launcher_static' => ["V1 launch sites"],
    'military' => ["bases"], 
    'industrial' => ["industrial buildings"],
    'rail' => ["industrial buildings"],
    'tank_static' => ["tanks", "ground units"],
    'radar_static' => ["bases", "radar sites"],
    'vehicle_static' => ["ground units"],
  }

  # TODO:
  #   - Fuel Storage
  #   - Jabo
  #   - aerial targets
  #   - airfields as targets (OCA)

  def initialize(proto_path = nil)
    proto_path ||= Constants::PROTO_PATH
    @proto_buff_data = CampaignLibrary::Protobuf::CampaignState.decode File.read(proto_path)

    @allied_objectives = @proto_buff_data.Objectives.select do |objective|
      ["United States", "Great Britain"].include? objective.Country.Name
    end

    @axis_objectives = @proto_buff_data.Objectives.select do |objective|
      ["Germany"].include? objective.Country.Name
    end

    @axis_targets = Hash.new { |h, k| h[k] = [] }
    @allied_objectives.each do |objective|
      objective.CampaignObjective.Blocks.map do |block|
        target_types = TARGET_CATEGORIES_MAP[block.Category] || []
        target_types.each do |target_type|
          @axis_targets[target_type] << objective.Name
        end
      end
    end
    @axis_targets.transform_values! do |ao_list|
      ao_list.uniq
    end
    @axis_targets.delete nil

    @allied_targets = Hash.new { |h, k| h[k] = [] }
    @axis_objectives.each do |objective|
      objective.CampaignObjective.Blocks.map do |block|
        target_types = TARGET_CATEGORIES_MAP[block.Category] || []
        target_types.each do |target_type|
          @allied_targets[target_type] << objective.Name
        end
      end
    end
    @allied_targets.transform_values! do |ao_list|
      ao_list.uniq
    end
    @allied_targets.delete nil

    # TODO: loadouts
    @allied_airframes = { 
      raf: Hash.new { |h, k| h[k] = [] },
      usaaf: Hash.new { |h, k| h[k] = [] },
      vvs: Hash.new { |h, k| h[k] = [] },
    }
    @proto_buff_data.Airfields.select do |objective|
      "Great Britain" == objective.Country.Name
    end.each do |airfield|
      airfield.CampaignAirfield.AvailableAirframes.each do |airframe|
        @allied_airframes[:raf][airframe.Model.split('\\').last.split('.').first] << airfield.Name
      end
    end
    @allied_airframes[:raf].transform_values! do |airfield_list|
      airfield_list.uniq
    end

    @proto_buff_data.Airfields.select do |objective|
      "United States" == objective.Country.Name
    end.each do |airfield|
      airfield.CampaignAirfield.AvailableAirframes.each do |airframe|
        @allied_airframes[:usaaf][airframe.Model.split('\\').last.split('.').first] << airfield.Name
      end
    end
    @allied_airframes[:usaaf].transform_values! do |airfield_list|
      airfield_list.uniq
    end

    @proto_buff_data.Airfields.select do |objective|
      "USSR" == objective.Country.Name
    end.each do |airfield|
      airfield.CampaignAirfield.AvailableAirframes.each do |airframe|
        @allied_airframes[:vvs][airframe.Model.split('\\').last] << airfield.Name
      end
    end
    @allied_airframes[:vvs].transform_values! do |airfield_list|
      airfield_list.uniq
    end

    @axis_airframes = { luftwaffe: Hash.new { |h, k| h[k] = [] } }
    @proto_buff_data.Airfields.select do |objective|
      ["Germany"].include? objective.Country.Name
    end.each do |airfield|
      airfield.CampaignAirfield.AvailableAirframes.each do |airframe|
        @axis_airframes[:luftwaffe][airframe.Model.split('\\').last.split('.').first] << airfield.Name
      end
    end
    @axis_airframes.transform_values! do |airfield_list|
      airfield_list.uniq
    end
  end
end