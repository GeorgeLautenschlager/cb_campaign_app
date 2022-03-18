class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :raf_pilot, dependent: :destroy 
  has_one :usaaf_pilot, dependent: :destroy
  has_one :luftwaffe_pilot, dependent: :destroy
  has_many :cards, dependent: :destroy

  after_create :assign_pilots!

  def assign_pilots!
    update! raf_pilot: RafPilot.new
    update! usaaf_pilot: UsaafPilot.new
    update! luftwaffe_pilot: LuftwaffePilot.new
  end
end
