class CreateObjectOrTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :object_or_types do |t|
      t.string :name
      t.string :type
      t.integer :order
      t.references :verb, null: false, foreign_key: true

      t.timestamps
    end
  end
end
