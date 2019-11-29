class RemoveVoteCountFromSongs < ActiveRecord::Migration[6.0]
  def change

    remove_column :songs, :vote_count, :Integer
  end
end
