class TestMigration < ActiveRecord::Migration[7.1]
  def change
    create_table :test_records do |t|
      t.string :test_record
    end
  end
end
