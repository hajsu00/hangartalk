class CreateGliderInitialLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :glider_initial_logs do |t|
      t.date :date
      t.integer :non_power_total_time
      t.integer :non_power_total_number
      t.integer :pic_winch_time
      t.integer :pic_winch_number
      t.integer :pic_aero_tow_time
      t.integer :pic_aero_tow_number
      t.integer :solo_winch_time
      t.integer :solo_winch_number
      t.integer :solo_aero_tow_time
      t.integer :solo_aero_tow_number
      t.integer :dual_winch_time
      t.integer :dual_winch_number
      t.integer :dual_aero_tow_time
      t.integer :dual_aero_tow_number
      t.integer :power_total_time
      t.integer :power_total_number
      t.integer :pic_power_time
      t.integer :pic_power_number
      t.integer :pic_power_off_time
      t.integer :pic_power_off_number
      t.integer :solo_power_time
      t.integer :solo_power_number
      t.integer :solo_power_off_time
      t.integer :solo_power_off_number
      t.integer :dual_power_time
      t.integer :dual_power_number
      t.integer :dual_power_off_time
      t.integer :dual_power_off_number
      t.integer :cross_country_time
      t.integer :instructor_time
      t.integer :instructor_number
      t.integer :number_of_stall_recovery
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
