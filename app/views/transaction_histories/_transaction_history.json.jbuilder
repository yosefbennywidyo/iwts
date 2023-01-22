json.extract! transaction_history, :id, :created_at, :updated_at
json.url transaction_history_url(transaction_history, format: :json)
