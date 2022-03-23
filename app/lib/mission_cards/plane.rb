class MissionCards::Plane
  FIGHTERS = [
    'p51b5',
    'p51d15',
    'p47d22',
    'p47d28',
    'p40e1',
    'p39l1',
    'p38j25',
    'tempestmkvs2',
    'typhoonmkib',
    'spitfiremkxiv',
    'spitfiremkixe',
    'spitfiremkvb',
    'yak7bs36',
    'yak1s127',
    'yak1s69',
    'yak9s1',
    'yak9ts1',
    'lafns2',
    'la5s8',
    'lagg2s29',
    'mig3s24',
    'i16t24',
    'mc202s8',
    'bf109k4',
    'bf109g14',
    'bf109g6late',
    'bf109g6',
    'bf109g4',
    'bf109g2',
    'bf109f4',
    'bf109f2',
    'bf109e7',
    'fw190a3',
    'fw190a5',
    'fw190a6',
    'fw190a8',
    'b110g2',
    'bf110e2',
  ]

  # TODO: Missing Ju87
  ATTACKERS = [
    'p47d22',
    'p47d28',
    'typhoonmkib',
    'pe2s87',
    'pe2s35',
    'il2m43',
    'il2m42',
    'il2m41',
    'bf109e7',
    'fw190a5',
    'fw190a6',
    'fw190a8',
    'ju88a4',
    'hs129b2',
  ]

  BOMBERS = [
    'a20b',
    'pe2s87',
    'pe2s35',
    'he111h16',
    'he111h6',
    'ju88a4',
  ]

  RECONS = [

  ]
  
  TRANSPORTS = [
    'ju523mg4e'
  ]

  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def fighter?
    FIGHTERS.include? name
  end

  def attacker?
    ATTACKERS.include? name
  end

  def bomber?
    BOMBERS.include? name
  end
  
  def recon?
    RECONS.include? name
  end

  def transport?
    TRANSPORTS.include? name
  end
end