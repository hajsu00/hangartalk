class CreateGroupGliderflights < ActiveRecord::Migration[6.1]
  def change
    create_table :group_gliderflights do |t|
      t.integer :day_flight_number
      t.date :date
      t.string :departure_point
      t.string :arrival_point
      t.boolean :is_winch
      t.integer :fleet
      t.integer :front_seat
      t.string :front_flight_role
      t.integer :rear_seat
      t.string :rear_flight_role
      t.datetime :takeoff_time
      t.datetime :release_time
      t.datetime :landing_time
      t.integer :release_alt
      t.string :creator
      t.string :updater
      t.string :note
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
