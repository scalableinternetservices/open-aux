class AddAccessTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :accessToken, :string
  end
end
