class ChangeColumnName < ActiveRecord::Migration
   def change
    change_table :products do |t|
      t.rename :quntity, :quantity
     
    end
  end
end
