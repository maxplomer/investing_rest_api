module Main
  class TradesController < Volt::ModelController
    def index
      data = { some: "data" }
      render json: data
    end
  end
end
