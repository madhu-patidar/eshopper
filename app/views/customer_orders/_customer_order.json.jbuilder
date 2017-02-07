json.extract! customer_order, :id, :customer_id, :address_id, :status, :grand_total, :shipping_charges, :created_at, :updated_at
json.url customer_order_url(customer_order, format: :json)