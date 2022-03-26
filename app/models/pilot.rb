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

  def allied?
    false
  end

  def axis?
    false
  end

  def raf?
    false
  end

  def usaaf?
    false
  end

  def luftwaffe?
    false
  end

  def vvs?
    false
  end

  def names_filename
    raise NoMethodError
  end

  private
  def self.names_file_path(pilot, position)
    path = 'static_data/names/'

    if position == :first
      path.concat 'FirstNames'
    elsif
      path.concat 'LastNames'
    else
      raise ArgumentError, 'Unrecognized value for position.'
    end

    path.concat pilot.names_filename
  end
end
