class CreateAircraftTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :aircraft_types do |t|
      t.string :aircraft_type
      t.string :category

      t.timestamps
    end
  end
end
