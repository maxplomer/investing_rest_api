module Main
  class TradesController < Volt::HttpController
    def index
      data = store._trades.all
      render json: data
    end
  end
end
