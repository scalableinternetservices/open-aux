class RemoveFieldNameFromSong < ActiveRecord::Migration[6.0]
  def change

    remove_column :songs, :songId, :string
  end
end
