class Gallery < ApplicationRecord
  has_many :gallery_artworks
  has_many :artworks, through: :gallery_artworks

  HOME_GALLERY_ID = -1
end