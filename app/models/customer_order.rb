class CustomerOrder < ActiveRecord::Base
  
  belongs_to :customer
  belongs_to :address
  has_many :order_details, dependent: :destroy
  has_many :track_orders, dependent: :destroy
  has_one :online_transaction
  
  default_scope -> { order('created_at DESC') }

  after_update :create_record

  def create_record
    self.track_orders.create(status: status)
  end

  scope :month_success_order,  -> { where.not(status: ["cancel", "pending"]).group_by{|u| u.created_at.strftime("%Y %B")} }

  scope :month_pending_order,  -> { where(status: "pending").group_by{|u| u.created_at.strftime("%Y %B")} }
  
end
