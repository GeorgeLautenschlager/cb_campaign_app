class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :allied_pilot, dependent: :destroy 
  has_one :axis_pilot, dependent: :destroy

  after_create :assign_pilots!

  def assign_pilots!
    update!(allied_pilot: AlliedPilot.new)
    update!(axis_pilot: AxisPilot.new)
  end

  def kill_allied_pilot!
    update!(allied_pilot: AlliedPilot.new)
  end

  def kill_axis_pilot
    update!(axis_pilot: AxisPilot.new)
  end
end
