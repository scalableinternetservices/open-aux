class Song < ApplicationRecord
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs
  #has_and_belongs_to_many :playlist
end
