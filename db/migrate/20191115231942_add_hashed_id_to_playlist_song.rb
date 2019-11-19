class AddHashedIdToPlaylistSong < ActiveRecord::Migration[6.0]
  def change
    add_column :playlist_songs, :hashed_id, :string
  end
end
