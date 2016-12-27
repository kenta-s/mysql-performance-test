json.extract! user, :id, :email, :last_name, :first_name, :nickname, :country, :date_of_birth, :created_at, :updated_at
json.url user_url(user, format: :json)