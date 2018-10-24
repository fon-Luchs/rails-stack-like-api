class ChangeRateTypeForQuestion < ActiveRecord::Migration[5.2]
  def change
    change_column :questions, :rating, :integer, :default => 0
  end
end
