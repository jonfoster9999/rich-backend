class Artwork < ApplicationRecord
  belongs_to :gallery, optional: true

  has_one_attached :artwork_file do |attachable|
    # Create a web-optimized version that will be used for display
    attachable.variant :web, resize_to_limit: [1200, nil], preprocessed: true
    # Thumbnail for admin panel
    attachable.variant :thumb, resize_to_limit: [200, 200], preprocessed: true
  end

  # Make sure the attachment is purged when the record is deleted
  before_destroy :purge_attachments

  private

  def purge_attachments
    artwork_file.purge_later if artwork_file.attached?
  end
end