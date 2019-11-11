class CreateRandomCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :random_characters do |t|
      t.string :name
      t.string :gender

      t.timestamps
    end
  end
end
