class Category < ActiveRecord::Base
  has_many :brand_categories,dependent: :destroy
  has_many :sub_categories, class_name: "Category", foreign_key: "category_id",dependent: :destroy
  belongs_to :category
  has_many :brands, through: :brand_categories,dependent: :destroy
  has_many :products, dependent: :destroy
  
  validates :status, inclusion: { in: %w(active draft achirved complete),
    message: "%{value} is not a valid status! choose only active, draft, achirved, complete " }, allow_blank: true
    
end
