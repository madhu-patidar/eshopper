class Category < ActiveRecord::Base
  belongs_to :category
  has_many :brand_categories, dependent: :destroy
  has_many :sub_categories, class_name: "Category", foreign_key: "category_id",dependent: :destroy
  has_many :brands, through: :brand_categories, dependent: :destroy
  has_many :products, dependent: :destroy
end
