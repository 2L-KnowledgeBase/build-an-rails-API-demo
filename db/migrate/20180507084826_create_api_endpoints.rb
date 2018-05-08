class CreateApiEndpoints < ActiveRecord::Migration[5.2]
  def change
    create_table :api_endpoints do |t|
      t.string :private_name
      t.string :public_name
      t.string :url
      t.timestamps
    end
  end
end
