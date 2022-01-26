class CreateAeroplaneInitialLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :aeroplane_initial_logs do |t|
      t.integer :total_flight_number
      t.integer :number_of_takeoff
      t.integer :number_of_landing
      t.integer :flight_time
      t.integer :pic_time
      t.integer :solo_time
      t.integer :xc_time
      t.integer :night_time
      t.integer :dual_time
      t.integer :dual_xc_time
      t.integer :dual_night_time
      t.integer :hood_time
      t.integer :instrument_time
      t.integer :simulator_time
      t.integer :instructor_time
      t.integer :number_of_stall_recovery
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
