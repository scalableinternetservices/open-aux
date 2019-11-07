class Song < ApplicationRecord
  has_and_belongs_to_many :playlist
end
