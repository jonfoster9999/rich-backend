class Artwork < ApplicationRecord
  has_many :gallery_artworks
  has_many :galleries, through: :gallery_artworks

  has_one_attached :artwork_file do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200], preprocessed: true
  end

  private
end