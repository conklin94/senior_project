class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.text :text
      t.string :author
      t.string :title
      t.timestamps
    end
  end
end
