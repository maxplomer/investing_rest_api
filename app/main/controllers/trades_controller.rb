module Main
  class TradesController < Volt::HttpController
    def index
      data = store._trades.all
      render json: data
    end

    def create
      data = {company: params._company, shares: params._shares.to_i}
      store._trades << data
      render json: data
    end

    private

    # Overwrite head method to allow api calls from different origins
    def head(status, additional_headers = {})
      @response_status = status
      response_headers.merge!(additional_headers)
      response_headers.merge!({"Access-Control-Allow-Origin": "*"})
    end

  end
end
