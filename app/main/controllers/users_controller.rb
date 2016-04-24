module Main
  class UsersController < Volt::HttpController
    def create
      body = JSON.parse(request.body.read)
      email = body["email"]
      password = body["password"]
      p email
      p password

      data = {id_token: '12345678'}
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
