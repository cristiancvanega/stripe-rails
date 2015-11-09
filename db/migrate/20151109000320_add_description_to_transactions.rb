class AddDescriptionToTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions, :description, :string
  end
end
