class Coupon < ActiveRecord::Base
  has_many :used_coupons
end
