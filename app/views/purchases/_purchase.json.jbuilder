json.extract! purchase, :id, :cart_id, :product_id, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
