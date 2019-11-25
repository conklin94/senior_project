class AddWeightToVerbs < ActiveRecord::Migration[6.0]
  def change
    add_column :verbs, :weight, :integer, :default => 1
  end
end
