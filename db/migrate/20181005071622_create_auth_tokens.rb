class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_tokens do |t|
      t.integer :user_id
      t.string :value

      t.timestamps
    end
  end
end
