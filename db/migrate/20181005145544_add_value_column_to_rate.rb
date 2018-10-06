class AddValueColumnToRate < ActiveRecord::Migration[5.2]
  def change
    add_column :rates, :value, :integer
  end
end
