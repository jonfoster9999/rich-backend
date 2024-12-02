class AddHomeToArtworks < ActiveRecord::Migration[7.1]
  def change
    add_column :artworks, :home, :boolean, default: false
  end
end
