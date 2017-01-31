class AddDefaultValueToCategories < ActiveRecord::Migration
  def change
    change_column :categories, :category_id, :integer, :default => nil
  end
end
