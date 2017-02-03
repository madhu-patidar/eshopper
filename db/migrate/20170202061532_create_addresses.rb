class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :customer, index: true, foreign_key: true
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :address_type
      t.string :name
      t.string :mobile_number

      t.timestamps null: false
    end
  end
end
