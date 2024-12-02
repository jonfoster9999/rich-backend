class Artwork < ApplicationRecord
  has_one_attached :artwork_file do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200], preprocessed: true
  end
end