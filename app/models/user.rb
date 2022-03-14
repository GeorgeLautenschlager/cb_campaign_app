class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :allied_pilot, dependent: :destroy 
  has_one :axis_pilot, dependent: :destroy
  has_many :cards, dependent: :destroy

  # after_create :assign_pilots!, :deal_new_hand!

  # def assign_pilots!
  #   update!(allied_pilot: AlliedPilot.new)
  #   update!(axis_pilot: AxisPilot.new)
  # end

  # def kill_allied_pilot!
  #   update!(allied_pilot: AlliedPilot.new)
  # end

  # def kill_axis_pilot
  #   update!(axis_pilot: AxisPilot.new)
  # end

  # def deal_new_hand!
  #   # update!(cards: Card.deal_new_hand)
  # end
end
