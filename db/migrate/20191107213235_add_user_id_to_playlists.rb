class AddUserIdToPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :userId, :integer
  end
end
