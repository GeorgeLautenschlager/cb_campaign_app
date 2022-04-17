class RafPilot < AlliedPilot
  def raf?
    true
  end

  def names_filename
    'Britain.txt'
  end

  # TODO: this should be a proper association
  def airforce
    Airforce.find_by(name: "RAF")
  end
end