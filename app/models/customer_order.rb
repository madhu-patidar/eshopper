class CustomerOrder < ActiveRecord::Base
  belongs_to :customer
  belongs_to :address
  has_many :order_details
end
