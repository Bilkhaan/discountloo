class AddAuthenticityToken < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string, limit: 100
    add_index  :users, :authentication_token, unique: true
  end
end
