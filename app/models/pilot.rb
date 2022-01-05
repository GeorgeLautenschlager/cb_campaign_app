class Pilot < ApplicationRecord
  belongs_to :user, optional: true

  after_initialize :assign_names!, if: :new_record?

  def assign_names!
    assign_first_name!
    assign_last_name!
  end

  def assign_first_name!
    self.first_name = File.readlines(self.class.names_file_path(self, :first)).sample.strip
  end

  def assign_last_name!
    self.last_name = File.readlines(self.class.names_file_path(self, :last)).sample.strip
  end

  def to_s
    "#{first_name} #{last_name}"
  end

  private
  def self.names_file_path(pilot, position)
    path = 'lib/names/'

    if position == :first
      path.concat 'FirstNames'
    elsif
      path.concat 'LastNames'
    else
      raise ArgumentError, 'Unrecognized value for position.'
    end

    if pilot.allied?
      path.concat 'USA.txt'
    else
      path.concat 'Germany.txt'
    end
  end
end
