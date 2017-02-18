class CreateTrackOrders < ActiveRecord::Migration
  def change
    create_table :track_orders do |t|
      t.references :customer_order, index: true, foreign_key: true
      t.string :status

      t.timestamps null: false
    end
  end
end
