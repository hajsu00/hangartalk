class CreateGliderGroupFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :glider_group_flights do |t|
      t.integer :day_flight_number
      t.date :date
      t.string :departure_and_arrival_point
      t.boolean :is_winch
      t.string :glider_type
      t.string :glider_ident
      t.string :front_seat
      t.string :front_flight_role
      t.string :rear_seat
      t.string :rear_flight_role
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
