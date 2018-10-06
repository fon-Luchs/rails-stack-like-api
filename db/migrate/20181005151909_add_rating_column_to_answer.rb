class AddRatingColumnToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :rating, :integer
  end
end
