class CreateGliderflightMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :gliderflight_microposts do |t|
      t.references :micropost, null: false, foreign_key: true
      t.references :gliderflight, null: false, foreign_key: true

      t.timestamps
    end
  end
end
