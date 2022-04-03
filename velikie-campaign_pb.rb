# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: velikie-campaign.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "campaign_library.protobuf.CampaignAirfield" do
    repeated :Blocks, :message, 1, "campaign_library.protobuf.CampaignBlock"
    repeated :AvailableAirframes, :message, 2, "campaign_library.protobuf.CampaignAvailableAirframe"
  end
  add_message "campaign_library.protobuf.CampaignAvailableAirframe" do
    optional :Name, :string, 1
    optional :Script, :string, 2
    optional :Model, :string, 3
    optional :AvMods, :string, 4
    optional :AvSkins, :string, 5
    optional :AvPayloads, :string, 6
  end
  add_message "campaign_library.protobuf.CampaignBlock" do
    optional :Model, :string, 1
    optional :Health, :double, 2
    optional :DestroyedComponents, :int32, 3
    optional :Position, :message, 4, "campaign_library.protobuf.CampaignPosition"
    optional :Category, :string, 5
  end
  add_message "campaign_library.protobuf.CampaignCountry" do
    optional :Name, :string, 1
    optional :Code, :int32, 2
  end
  add_message "campaign_library.protobuf.CampaignDay" do
    optional :Year, :int32, 1
    optional :Month, :int32, 2
    optional :Day, :int32, 3
    optional :DayInCampaign, :int32, 4
  end
  add_message "campaign_library.protobuf.CampaignFrontLine" do
    optional :Name, :string, 1
    repeated :PositionsInFrontLine, :message, 2, "campaign_library.protobuf.CampaignPosition"
  end
  add_message "campaign_library.protobuf.CampaignObjective" do
    optional :Type, :enum, 1, "campaign_library.protobuf.CampaignObjectiveType"
    repeated :Blocks, :message, 2, "campaign_library.protobuf.CampaignBlock"
  end
  add_message "campaign_library.protobuf.CampaignPosition" do
    optional :X, :double, 1
    optional :Y, :double, 2
    optional :Z, :double, 3
  end
  add_message "campaign_library.protobuf.CampaignState" do
    optional :Name, :string, 1
    repeated :Airfields, :message, 2, "campaign_library.protobuf.CampaignSupplyPoint"
    repeated :Objectives, :message, 3, "campaign_library.protobuf.CampaignSupplyPoint"
    optional :FrontLine, :message, 4, "campaign_library.protobuf.CampaignFrontLine"
    optional :Day, :message, 5, "campaign_library.protobuf.CampaignDay"
    optional :PlayAreaBoundaryNorthWest, :message, 6, "campaign_library.protobuf.CampaignPosition"
    optional :PlayAreaBoundarySouthEast, :message, 7, "campaign_library.protobuf.CampaignPosition"
    repeated :TemplatedBlocks, :message, 8, "campaign_library.protobuf.CampaignBlock"
  end
  add_message "campaign_library.protobuf.CampaignSupplyPoint" do
    optional :Name, :string, 1
    optional :Position, :message, 2, "campaign_library.protobuf.CampaignPosition"
    optional :Country, :message, 3, "campaign_library.protobuf.CampaignCountry"
    optional :SupplyLevel, :int32, 4
    optional :ActiveToday, :bool, 5
    oneof :subtype do
      optional :CampaignAirfield, :message, 11, "campaign_library.protobuf.CampaignAirfield"
      optional :CampaignObjective, :message, 12, "campaign_library.protobuf.CampaignObjective"
    end
  end
  add_enum "campaign_library.protobuf.CampaignObjectiveType" do
    value :UNKNOWN, 0
    value :STRATEGIC, 1
    value :POP_UP, 2
  end
end

module CampaignLibrary
  module Protobuf
    CampaignAirfield = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignAirfield").msgclass
    CampaignAvailableAirframe = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignAvailableAirframe").msgclass
    CampaignBlock = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignBlock").msgclass
    CampaignCountry = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignCountry").msgclass
    CampaignDay = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignDay").msgclass
    CampaignFrontLine = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignFrontLine").msgclass
    CampaignObjective = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignObjective").msgclass
    CampaignPosition = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignPosition").msgclass
    CampaignState = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignState").msgclass
    CampaignSupplyPoint = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignSupplyPoint").msgclass
    CampaignObjectiveType = Google::Protobuf::DescriptorPool.generated_pool.lookup("campaign_library.protobuf.CampaignObjectiveType").enummodule
  end
end
