class ChangeReputationForUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :reputation, :integer, default: 0
  end
end
