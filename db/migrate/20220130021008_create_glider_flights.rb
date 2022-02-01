class CreateGliderFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :glider_flights do |t|
      t.integer :log_number
      t.date :departure_date
      t.string :glider_type
      t.string :glider_ident
      t.string :departure_point
      t.string :arrival_point
      t.integer :number_of_landing
      t.datetime :takeoff_time
      t.datetime :landing_time
      t.boolean :is_pic
      t.boolean :is_dual
      t.boolean :is_motor_glider
      t.boolean :is_power_flight
      t.boolean :is_winch
      t.boolean :is_cross_country
      t.string :release_alt
      t.boolean :is_instructor
      t.boolean :is_stall_recovery
      t.boolean :close_log
      t.string :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
