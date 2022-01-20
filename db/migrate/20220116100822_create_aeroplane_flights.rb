class CreateAeroplaneFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :aeroplane_flights do |t|
      t.integer :log_number
      t.date :departure_date
      t.string :aeroplane_type
      t.string :aeroplane_ident
      t.datetime :moving_time
      t.datetime :stop_time
      t.boolean :is_pic
      t.boolean :is_cross_country
      t.boolean :is_instructor
      t.string :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :aeroplane_flights, [:user_id, :created_at]
  end
end
