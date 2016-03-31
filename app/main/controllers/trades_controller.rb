module Main
  class TradesController < Volt::HttpController
    def index
      data = { some: "data" }
      render json: data
    end
  end
end
