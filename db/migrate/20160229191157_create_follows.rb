class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps null: false
    end
    add_index :follows, [:follower_id, :followed_id], unique: true

  end
end
