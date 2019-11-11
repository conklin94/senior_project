class CreateRandomPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :random_places do |t|
      t.string :name

      t.timestamps
    end
  end
end
