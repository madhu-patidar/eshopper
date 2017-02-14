class CreateOnlineTransactions < ActiveRecord::Migration
  def change
    create_table :online_transactions do |t|
      t.string :transaction_id
      t.decimal :amount
      t.references :customer, index: true, foreign_key: true
      t.references :customer_order, index: true, foreign_key: true
      t.string :stripe_token
      t.string :stripe_email

      t.timestamps null: false
    end
  end
end
