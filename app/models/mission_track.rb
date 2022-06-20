class MissionTrack > ApplicationRecord
  include AASM

  belongs_to :card

  aasm do
    state :active, initial: true
    state :spawned
    state :in_flight
    state :objective_met
    state :successful

    event :spawn do
      transitions from: active, to: :spawned
    end

    event :takeoff do
      transitions from: :spawned, to: :in_flight
    end

    event :meet_objective do
      transitions from: :in_flight, to: :objective_met
    end

    event :success do
      transitions from: :meet_objective, to: :successful
    end
  end
end
