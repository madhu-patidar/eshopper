class CustomerOrder < ActiveRecord::Base
  belongs_to :customer
  belongs_to :address
  has_many :order_details, dependent: :destroy
  has_one :online_transaction
  
  default_scope -> { order('created_at DESC') }
  after_update :create_record


  def create_record
    @order = CustomerOrder.find(id)
    @trackorder = TrackOrder.new(customer_order_id: @order.id, status: @order.status)
    @trackorder.save
  end
end
