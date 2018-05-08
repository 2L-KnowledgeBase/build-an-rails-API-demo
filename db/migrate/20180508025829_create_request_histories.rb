class CreateRequestHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :request_histories do |t|
      t.integer :api_user_id 
      t.integer :api_endpoint_id 
      t.string :request_parameter 
      t.timestamps
    end
  end
end
