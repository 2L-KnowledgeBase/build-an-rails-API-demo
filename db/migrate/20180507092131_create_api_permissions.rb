class CreateApiPermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :api_permissions do |t|
      t.integer :api_user_id
      t.integer :api_endpoint_id
      t.integer :request_times, default: 0
      t.timestamps
    end
  end
end
