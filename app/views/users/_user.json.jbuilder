json.extract! user, :id, :email, :username, :role, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
