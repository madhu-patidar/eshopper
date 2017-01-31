class CreateBrandCategories < ActiveRecord::Migration
  def change
    create_table :brand_categories do |t|
      t.belongs_to :category, index: true
      t.belongs_to :brand, index: true
      t.timestamps null: false
    end
  end
end
