json.extract! address, :id, :customer_id, :address_1, :address_2, :city, :state, :country, :zipcode, :address_type, :name, :mobile_number, :created_at, :updated_at
json.url address_url(address, format: :json)