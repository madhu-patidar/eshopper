class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.decimal :percent_off
      t.integer :no_of_uses, :default => 0

      t.timestamps null: false
    end
  end
end
