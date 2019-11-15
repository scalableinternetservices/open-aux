class AddHashedIdToPlaylist < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :hashed_id, :string
  end
end
