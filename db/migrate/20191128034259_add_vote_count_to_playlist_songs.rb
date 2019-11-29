class AddVoteCountToPlaylistSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :playlist_songs, :vote_count, :integer
  end
end
