json.extract! user, :code, :name, :email, :created_at, :updated_at
json.url user_url(user.code, format: :json)
