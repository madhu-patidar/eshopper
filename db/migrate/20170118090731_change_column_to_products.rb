class ChangeColumnToProducts < ActiveRecord::Migration
  def change
    change_column :products, :short_description, :string
  end
end
