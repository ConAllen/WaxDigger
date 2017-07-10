json.extract! order, :id, :address, :town_or_city, :state_or_county, :post_or_zip_code, :country, :created_at, :updated_at
json.url order_url(order, format: :json)
