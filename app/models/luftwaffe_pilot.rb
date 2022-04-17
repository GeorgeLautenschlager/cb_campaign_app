class LuftwaffePilot < AxisPilot
  def luftwaffe?
    true
  end

  def names_filename
    'Germany.txt'
  end

  # TODO: this should be a proper association
  def airforce
    Airforce.find_by(name: "Luftwaffe")
  end
end