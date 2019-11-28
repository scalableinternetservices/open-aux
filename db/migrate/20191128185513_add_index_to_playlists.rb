class AddIndexToPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_index :playlists, :hashed_id
  end
end
