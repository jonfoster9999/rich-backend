class Gallery < ApplicationRecord
  has_many :artworks

  HOME_GALLERY_ID = -1
end