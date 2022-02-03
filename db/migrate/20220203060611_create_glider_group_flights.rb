class CreateGliderGroupFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :glider_group_flights do |t|
      t.integer :day_flight_number
      t.date :date
      t.string :place
      t.string :way_of_towing
      t.string :fleet
      t.string :front_seat
      t.string :front_seat_attribute
      t.string :rear_seat
      t.string :rear_seat_attribute
      t.datetime :takeoff_time
      t.datetime :release_time
      t.datetime :landing_time
      t.integer :release_alt
      t.string :creator
      t.string :updater
      t.string :notes
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
