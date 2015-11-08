class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :id_transaction_stripe
      t.integer :amount

      t.timestamps null: false
    end
  end
end
