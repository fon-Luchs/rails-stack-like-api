class AddRateableTypeToRate < ActiveRecord::Migration[5.2]
  def change
    add_column :rates, :rateable_type, :string
  end
end
