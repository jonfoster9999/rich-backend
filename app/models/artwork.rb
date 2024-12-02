class Artwork < ApplicationRecord
  before_save :ensure_only_one_home

  has_one_attached :artwork_file do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200], preprocessed: true
  end

  private

  def ensure_only_one_home
    if home?
      self.class.where(home: true).update_all(home: false)
    end
  end
end