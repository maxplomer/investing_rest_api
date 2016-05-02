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

    def my_trades
      id_token = params._idToken
      user_id = params._id

      AuthTasks.authenticate_user(user_id, id_token).then do
        # Only want the 10 most recent
        store._trades.where(user_id: user_id).length.then do |trades_length|
          if trades_length > 10
            data = store._trades.where(user_id: user_id).skip(trades_length - 10).limit(10).all
          else
            data = store._trades.where(user_id: user_id).all
          end

          render json: data
        end
      end.fail do |error|
        puts "Error: #{error}"
      end
    end

    def create
      body = JSON.parse(request.body.read)
      id_token = body["idToken"]
      user_id = body["id"]

      data = {
        company: body["company"], 
        shares: body["shares"].to_i,
        user_id: user_id
      }

      AuthTasks.authenticate_user(user_id, id_token).then do
        store._trades << data
        render json: data
      end.fail do |error|
        puts "Error: #{error}"
      end
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
