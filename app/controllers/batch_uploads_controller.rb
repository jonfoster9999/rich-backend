class BatchUploadsController < ApplicationController
  def create
    gallery_id = params[:gallery_id]
    files = params[:files] || []

    if gallery_id.blank?
      return render json: { error: "Gallery ID is required" }, status: :unprocessable_entity
    end

    if files.empty?
      return render json: { error: "No files were uploaded" }, status: :unprocessable_entity
    end

    # Find the gallery
    gallery = Gallery.find_by(id: gallery_id)

    if gallery.nil?
      return render json: { error: "Gallery not found" }, status: :not_found
    end

    # Track successful and failed uploads
    results = {
      successful: [],
      failed: []
    }

    # Process each file
    files.each do |file|
      artwork = Artwork.new(gallery_id: gallery_id)
      artwork.artwork_file.attach(file)

      if artwork.save
        results[:successful] << {
          id: artwork.id,
          filename: file.original_filename
        }
      else
        results[:failed] << {
          filename: file.original_filename,
          errors: artwork.errors.full_messages
        }
      end
    end

    # Process the images in the background if there were successful uploads
    if results[:successful].any?
      artworks = Artwork.where(id: results[:successful].map { |s| s[:id] })
      ImageProcessorService.process_batch(artworks)
    end

    # Return the results
    render json: {
      message: "Batch upload processed",
      successful_count: results[:successful].count,
      failed_count: results[:failed].count,
      results: results
    }
  end
end