class RefactorArtworkGalleryRelationship < ActiveRecord::Migration[7.1]
  def change
    drop_table :gallery_artworks
    add_column :artworks, :gallery_id, :integer
  end
end
