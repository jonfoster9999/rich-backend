class GalleriesController < ApplicationController
  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      render json: @gallery
    else
      render json: { error: @gallery.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def index
    @galleries = Gallery.where.not(id: Gallery::HOME_GALLERY_ID)
    render json: @galleries
  end

  def show
    @gallery = Gallery.find_by(id: params[:id])

    if @gallery
      render json: @gallery
    else
      render json: { error: "Gallery not found" }, status: :not_found
    end
  end

  def update
    @gallery = Gallery.find_by(id: params[:id])

    if @gallery
      if @gallery.update(gallery_params)
        render json: @gallery
      else
        render json: { error: @gallery.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    else
      render json: { error: "Gallery not found" }, status: :not_found
    end
  end

  def destroy
    @gallery = Gallery.find_by(id: params[:id])

    if @gallery
      if @gallery.destroy
        render json: { message: "Gallery successfully deleted" }
      else
        render json: { error: "Failed to delete gallery" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Gallery not found" }, status: :not_found
    end
  end

  private

  def gallery_params
    params.permit(:name)
  end
end