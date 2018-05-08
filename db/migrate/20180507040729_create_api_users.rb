class CreateApiUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :api_users do |t|
      t.string :name
      t.string :email
      t.string :authentication_token
      t.string :password_digest
      t.integer :user_id
      t.timestamps
    end
  end
end
