class CreateShareRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :share_relationships do |t|
      t.integer :share_tweet_id
      t.integer :main_tweet_id

      t.timestamps
    end
      add_index :share_relationships, :share_tweet_id
      add_index :share_relationships, :main_tweet_id
      add_index :share_relationships, [:share_tweet_id, :main_tweet_id]
  end
end
