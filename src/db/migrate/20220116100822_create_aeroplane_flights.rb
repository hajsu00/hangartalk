class CreateAeroplaneFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :aeroplane_flights do |t|
      t.integer :log_number
      t.date :date
      t.string :aeroplane_type
      t.string :aeroplane_ident
      t.string :departure_point
      t.string :arrival_point
      t.string :exercises_or_maneuvers
      t.integer :number_of_takeoff
      t.integer :number_of_landing
      t.datetime :moving_time
      t.datetime :stop_time
      t.string :flight_role
      t.boolean :is_cross_country
      t.boolean :is_night_flight
      t.boolean :is_hood
      t.boolean :is_instrument
      t.boolean :is_simulator
      t.boolean :is_instructor
      t.boolean :is_stall_recovery
      t.boolean :close_log
      t.string :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :aeroplane_flights, [:user_id, :created_at]
  end
end
