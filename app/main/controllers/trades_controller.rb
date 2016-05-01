require "auth0"

module Main
  class TradesController < Volt::HttpController
    def index
      # Only want the 10 most recent
      store._trades.length.then do |trades_length|
        if trades_length > 10
          data = store._trades.skip(trades_length - 10).limit(10).all
        else
          data = store._trades.all
        end

        render json: data
      end
    end

    def create
      body = JSON.parse(request.body.read)
      id_token = body["idToken"]
      user_id = body["id"]

      # Check if user to be acted on matches subject in bearer token
      auth0 = Auth0Client.new(
        :api_version => 2,
        :token => id_token,
        :domain => ENV["AUTH0_DOMAIN"]
      )

      auth0.user(user_id)

      data = {company: body["company"], shares: body["shares"].to_i}
      store._trades << data
      render json: data
    end

    private

    # Overwrite head method to allow api calls from different origins
    def head(status, additional_headers = {})
      @response_status = status
      response_headers.merge!(additional_headers)
      response_headers.merge!({"Access-Control-Allow-Origin": ENV["ACCESS_CONTROL_ALLOW_ORIGIN"]})
    end

  end
end
