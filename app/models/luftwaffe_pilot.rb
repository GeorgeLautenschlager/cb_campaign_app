class LuftwaffePilot < AxisPilot
  def luftwaffe?
    true
  end

  def names_filename
    'Germany.txt'
  end
end