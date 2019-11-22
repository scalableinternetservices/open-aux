class PlaylistSong < ApplicationRecord
  belongs_to :song, optional:true
  # belongs_to :playlist
end
