class PlaylistSong < ApplicationRecord
  belongs_to :song #, optional:true
  belongs_to :playlist, 
    foreign_key: "hashed_id",
    primary_key: "hashed_id"
  # belongs_to :playlist
end
