class Brand < ActiveRecord::Base
  has_many :brand_categories,dependent: :destroy
  has_many :categories, through: :brand_categories,dependent: :destroy
  has_many :products, dependent: :destroy
  
  validates :name, presence: true
  scope :brand_with_product, -> { Brand.joins("INNER JOIN products ON products.brand_id = brands.id LIMIT 10").uniq }
end
