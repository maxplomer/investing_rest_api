module Main
  class UsersController < Volt::HttpController
    def create
      data = {hello: 'world'}
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
