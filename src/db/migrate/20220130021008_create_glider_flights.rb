class CreateGliderFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :glider_flights do |t|
      t.integer :log_number
      t.date :date
      t.string :glider_ident
      t.string :departure_point
      t.string :arrival_point
      t.integer :number_of_landing
      t.datetime :takeoff_time
      t.datetime :landing_time
      t.string :flight_role
      t.boolean :is_winch
      t.boolean :is_cross_country
      t.integer :release_alt
      t.boolean :is_instructor
      t.boolean :is_stall_recovery
      t.string :note
      t.references :user, null: false, foreign_key: true
      t.references :aircraft_type, foreign_key: true

      t.timestamps
    end
    add_index :glider_flights, [:user_id, :log_number]
  end
end
