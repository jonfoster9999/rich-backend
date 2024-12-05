class DropHomeFromArtworks < ActiveRecord::Migration[7.1]
  def change
    remove_column :artworks, :home
  end
end
