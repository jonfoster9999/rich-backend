class ImageProcessorService
  # Process an array of artworks, creating optimized variants
  def self.process_batch(artworks)
    artworks.each do |artwork|
      process_single(artwork)
    end
  end

  # Process a single artwork image
  def self.process_single(artwork)
    return unless artwork.artwork_file.attached?

    begin
      # Generate the web-optimized version
      artwork.artwork_file.variant(:web).processed

      # Generate the thumbnail version
      artwork.artwork_file.variant(:thumb).processed

      # If successful, log it
      Rails.logger.info("Successfully processed image for artwork ##{artwork.id}")
    rescue => e
      # Log the error but don't crash the application
      Rails.logger.error("Error processing image for artwork ##{artwork.id}: #{e.message}")
    end
  end
end