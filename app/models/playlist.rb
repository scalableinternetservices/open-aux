class Playlist < ApplicationRecord
  has_and_belongs_to_many :songs
  # belongs_to :user
  before_save { self.name = name.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
end
