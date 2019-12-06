class AddWeightToVerbs < ActiveRecord::Migration[6.0]
  def change
    add_column :verbs, :weight, :integer, :default => 50
  end
end
