class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :artwork_url, :thumbnail_url, :home

  def artwork_url
    object.artwork_file&.url
  end

  def thumbnail_url
    object.artwork_file.try(:variant, :thumb)&.url || ''
  rescue
    ''
  end
end

