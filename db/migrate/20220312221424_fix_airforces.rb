class FixAirforces < ActiveRecord::Migration[7.0]
  def change
    rename_column :airforces, :nationality, :coalition
  end
end
