class AddUniqueIndexToFollowTable < ActiveRecord::Migration[8.1]
  def change
    add_index :follows, [ :followed_id, :follower_id ], unique: true
  end
end
