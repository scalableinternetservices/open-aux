class AddSongIdToSong < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :songId, :string
  end
end
