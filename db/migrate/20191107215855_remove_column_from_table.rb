class RemoveColumnFromTable < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :playlists, index: true, foreign_key: true
  end
end
