class AddColumnToProducts < ActiveRecord::Migration
  def change
    change_column :products, :status, :integer
    rename_column :products, :description, :short_description
    add_column :products, :sku, :string
    add_column :products, :special_price, :decimal
    add_column :products, :long_description, :text
    add_column :products, :meta_title, :string
    add_column :products, :meta_description, :text
    add_column :products, :meta_keywords, :text
  end
end
