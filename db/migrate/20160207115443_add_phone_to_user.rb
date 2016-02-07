class AddPhoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string, limit: 50
  end
end
