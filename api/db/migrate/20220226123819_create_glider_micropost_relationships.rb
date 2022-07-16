class CreateGliderMicropostRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :glider_micropost_relationships do |t|
      t.references :micropost, null: false, foreign_key: true
      t.references :gliderflight, null: false, foreign_key: true

      t.timestamps
    end
  end
end
