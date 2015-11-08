class AddIdCustomerStripeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :id_customer, :string, default: ""
  	add_column :users, :enabled, :boolean, default: false
  	add_column :users, :last4, :integer
  	add_column :users, :brand, :string, default: ""
  end
end