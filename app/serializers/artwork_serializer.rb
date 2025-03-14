class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :caption, :gallery_id, :artwork_url, :thumbnail_url, :created_at

  def artwork_url
    return nil unless object.artwork_file.attached?

    begin
      # Try to get the web variant
      variant = object.artwork_file.variant(:web)
      # The call to processed will either return the existing variant
      # or generate it if it doesn't exist yet
      variant.processed
      return variant.url
    rescue => e
      # If there's any error (including if the variant can't be created)
      # fall back to the original file
      Rails.logger.error("Variant error for artwork ##{object.id}: #{e.message}")
      return object.artwork_file.url
    end
  end

  def thumbnail_url
    object.artwork_file.attached? ? object.artwork_file.variant(:thumb).url : nil
  rescue => e
    Rails.logger.error("Error generating thumbnail URL: #{e.message}")
    ''
  end
end