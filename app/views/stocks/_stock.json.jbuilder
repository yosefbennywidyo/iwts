json.extract! stock, :name, :email, :code, :created_at, :updated_at
json.url stock_url(stock.code, format: :json)
