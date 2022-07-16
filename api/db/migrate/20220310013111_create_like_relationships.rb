class CreateLikeRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :like_relationships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true

      t.timestamps
    end
    add_index :like_relationships, [:user_id, :micropost_id]
  end
end
