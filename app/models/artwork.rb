class Artwork < ApplicationRecord
  belongs_to :gallery, optional: true

  has_one_attached :artwork_file do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200], preprocessed: true
  end

  private
end