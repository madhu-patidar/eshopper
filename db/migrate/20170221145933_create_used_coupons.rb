class CreateUsedCoupons < ActiveRecord::Migration
  def change
    create_table :used_coupons do |t|
      t.references :customer, index: true, foreign_key: true
      t.references :customer_order, index: true, foreign_key: true
      t.references :coupon, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
