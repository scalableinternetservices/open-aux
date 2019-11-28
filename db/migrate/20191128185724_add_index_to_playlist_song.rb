class AddIndexToPlaylistSong < ActiveRecord::Migration[6.0]
  def change
    add_index :playlist_songs, :hashed_id
  end
end
