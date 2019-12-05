class PlaylistSong < ApplicationRecord
  after_commit :notify_playlist_updated, on: [:create, :update, :destroy]
  belongs_to :song #, optional:true
  belongs_to :playlist, 
    foreign_key: "hashed_id",
    primary_key: "hashed_id"
  # belongs_to :playlist

  def notify_playlist_updated
    PlaylistSong.connection.execute "NOTIFY update, 'data'"
  end

  def self.on_change
    PlaylistSong.connection.execute "LISTEN update"
    loop do
      PlaylistSong.connection.raw_connection.wait_for_notify do |event, pid, playlistsong|
        yield playlistsong
      end
    end
  ensure
    PlaylistSong.connection.execute "UNLISTEN update"
  end
end
