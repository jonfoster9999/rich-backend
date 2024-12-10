class GallerySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :artworks
end