class AddReputationColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reputation, :integer
  end
end
