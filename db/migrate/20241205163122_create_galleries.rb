class CreateGalleries < ActiveRecord::Migration[7.1]
  def change
    create_table :galleries do |t|
      t.string :name
      t.integer :sort_order, default: 0
      t.timestamps
    end
  end
end
