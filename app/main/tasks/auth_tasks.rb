require "auth0"
class AuthTasks < Volt::Task
  def authenticate_user(user_id, id_token)
    # Check if user to be acted on matches subject in bearer token
    auth0 = Auth0Client.new(
      :api_version => 2,
      :token => id_token,
      :domain => ENV["AUTH0_DOMAIN"]
    )

    auth0.user(user_id)
  end
end