class RemoveUserIdFromPlaylist < ActiveRecord::Migration[6.0]
  def change

    remove_column :playlists, :userId, :Integer
  end
end
