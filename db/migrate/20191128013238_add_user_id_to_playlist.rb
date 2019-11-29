class AddUserIdToPlaylist < ActiveRecord::Migration[6.0]
    def change
      add_column :playlists, :userId, :Integer
    end
  end
  