class CreateGalleryArtworks < ActiveRecord::Migration[7.1]
  def change
    create_table :gallery_artworks do |t|
      t.belongs_to :artwork
      t.belongs_to :gallery
      t.integer :sort_order, default: 0
      t.timestamps
    end
  end
end
