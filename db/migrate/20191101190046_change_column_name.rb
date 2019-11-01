class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :object_or_types, :type, :class_or_string
  end
end
