class Playlist < ApplicationRecord
  has_many :playlist_songs,
    foreign_key: "hashed_id",
    primary_key: "hashed_id"
  has_many :songs, through: :playlist_songs
  belongs_to :user
  # belongs_to :user
  before_save { self.name = name.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
end
