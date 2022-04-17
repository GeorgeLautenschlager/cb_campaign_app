class VvsPilot < AlliedPilot
  def vvs?
    true
  end

  def names_filename
    'Russia.txt'
  end

  # TODO: this should be a proper association
  def airforce
    Airforce.find_by(name: "VVS")
  end
end