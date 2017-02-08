class CreateCustomerOrders < ActiveRecord::Migration
  def change
    create_table :customer_orders do |t|
      t.references :customer, index: true, foreign_key: true
      t.references :address, index: true, foreign_key: true
      t.string :status
      t.decimal :grand_total
      t.decimal :shipping_charges

      t.timestamps null: false
    end
  end
end
