class GalleriesController < ApplicationController
  def create
    # @artwork = Artwork.new(artwork_params)
    #
    # if @artwork.save
    #   render json: @artwork
    # else
    #   render json: { error: @artwork.errors.full_messages.join(', ') }
    # end
  end

  def index
    @galleries = Gallery.where.not(id: Gallery::HOME_GALLERY_ID)
    render json: @galleries
  end

  def show
    @gallery = Gallery.find_by(id: params[:id])
    render json: @gallery
  end

  def home

  end


  private

  def gallery_params
    params.permit(:name)
  end
end