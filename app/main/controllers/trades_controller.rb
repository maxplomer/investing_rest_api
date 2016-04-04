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
  end
end
