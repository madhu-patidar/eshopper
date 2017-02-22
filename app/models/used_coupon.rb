class UsedCoupon < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_order
  belongs_to :coupon
end
