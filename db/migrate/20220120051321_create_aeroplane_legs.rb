class CreateAeroplaneLegs < ActiveRecord::Migration[6.1]
  def change
    create_table :aeroplane_legs do |t|
      t.string :departure_point
      t.string :arrival_point
      t.datetime :takeoff_time
      t.datetime :landing_time
      t.integer :number_of_takeoff
      t.integer :number_of_landing
      t.references :aeroplane_flight, null: false, foreign_key: true

      t.timestamps
    end
  end
end
