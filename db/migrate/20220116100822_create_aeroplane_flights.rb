class CreateAeroplaneFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :aeroplane_flights do |t|
      t.date :departure_date
      t.string :aeroplane_type
      t.string :aeroplane_ident
      t.datetime :moving_time
      t.datetime :stop_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :aeroplane_flights, [:user_id, :created_at]
  end
end
