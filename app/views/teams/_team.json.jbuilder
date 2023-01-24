json.extract! team, :name, :email, :code, :created_at, :updated_at
json.url team_url(team.code, format: :json)
