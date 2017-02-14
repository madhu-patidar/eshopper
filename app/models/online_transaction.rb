class OnlineTransaction < ActiveRecord::Base
  belongs_to :customer
  belongs_to :customer_order
end
