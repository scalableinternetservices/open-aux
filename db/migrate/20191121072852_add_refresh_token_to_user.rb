class AddRefreshTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :refreshToken, :string
  end
end
