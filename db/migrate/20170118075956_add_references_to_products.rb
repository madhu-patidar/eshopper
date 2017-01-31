class AddReferencesToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :brand, index: true
    add_reference :products, :category, index: true
  end
end
