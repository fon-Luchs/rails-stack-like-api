class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.integer :kind
      t.references :rateable, polimorphic: true, index: true
      t.timestamps
      t.integer :user_id
    end
  end
end
