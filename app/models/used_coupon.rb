class UsedCoupon < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_order
  belongs_to :coupon

  scope :monthly_used_coupons,  -> { all.group_by{|u| u.created_at.strftime("%Y %B")} } 

end
