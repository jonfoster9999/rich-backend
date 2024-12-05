class ArtworksController < ApplicationController
  def create
    @artwork = Artwork.new(artwork_params)

    if @artwork.save
      render json: @artwork
    else
      render json: { error: @artwork.errors.full_messages.join(', ') }
    end
  end

  def index
    @artworks = Artwork.all
    render json: @artworks
  end

  private

  def artwork_params
    params.permit(:caption, :artwork_file)
  end
end