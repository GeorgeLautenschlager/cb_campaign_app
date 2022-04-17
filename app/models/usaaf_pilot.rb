class UsaafPilot < AlliedPilot
  def usaaf?
    true
  end

  def names_filename
    'USA.txt'
  end

  # TODO: this should be a proper association
  def airforce
    Airforce.find_by(name: "USAAF")
  end
end