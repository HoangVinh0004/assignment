class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :province
      t.string :district
      t.string :street

      t.timestamps
    end
  end
end
