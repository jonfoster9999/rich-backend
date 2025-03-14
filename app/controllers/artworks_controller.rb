class ArtworksController < ApplicationController
  def create
    @artwork = Artwork.new(artwork_params)

    if @artwork.save
      # Process the image in the background if needed
      process_image(@artwork) if @artwork.artwork_file.attached?

      render json: @artwork
    else
      render json: { error: @artwork.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def index
    if params[:gallery_id]
      @artworks = Artwork.where(gallery_id: params[:gallery_id])
    else
      @artworks = Artwork.all
    end
    render json: @artworks
  end

  def show
    @artwork = Artwork.find_by(id: params[:id])

    if @artwork
      render json: @artwork
    else
      render json: { error: "Artwork not found" }, status: :not_found
    end
  end

  def destroy
    @artwork = Artwork.find_by(id: params[:id])

    if @artwork
      if @artwork.destroy
        render json: { message: "Artwork successfully deleted" }
      else
        render json: { error: "Failed to delete artwork" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Artwork not found" }, status: :not_found
    end
  end

  private

  def artwork_params
    params.permit(:caption, :artwork_file, :gallery_id)
  end

  # Process and resize the uploaded image
  def process_image(artwork)
    return unless artwork.artwork_file.attached?

    # Define a reasonable max size for website display (1200px max width)
    begin
      # This uses ActiveStorage variants to resize the image
      # The processed variant will be used for all image display
      artwork.artwork_file.variant(resize_to_limit: [1200, nil]).processed
    rescue => e
      Rails.logger.error("Error processing image: #{e.message}")
    end
  end
end
