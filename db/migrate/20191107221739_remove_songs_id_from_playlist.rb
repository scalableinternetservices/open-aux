class RemoveSongsIdFromPlaylist < ActiveRecord::Migration[6.0]
  def change
    remove_reference :playlists, :songs, index: true, foreign_key: true
  end
end
