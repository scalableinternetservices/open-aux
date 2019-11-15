class RemovePlaylistIdFromPlaylistSong < ActiveRecord::Migration[6.0]
  def change

    remove_column :playlist_songs, :playlist_id, :integer
  end
end
