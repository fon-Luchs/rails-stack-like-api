class ChangeReputationForAnswer < ActiveRecord::Migration[5.2]
  def change
    change_column :answers, :rating, :integer, default: 0
  end
end
