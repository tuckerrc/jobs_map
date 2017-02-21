class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.float :lat
      t.float :long
      t.string :country
      t.string :state

      t.timestamps
    end
  end
end
