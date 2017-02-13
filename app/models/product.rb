class Product < ActiveRecord::Base 
  belongs_to :brand
  belongs_to :category
  has_many  :pictures, as: :imageable, dependent: :destroy
  has_many  :cart_items, dependent: :destroy
  has_many :wish_lists, dependent: :destroy
  
  
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true 
  validates :name, presence: true  
end