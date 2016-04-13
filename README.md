# Ruby Investing Rest API

This is the backend for the Angular 2 app.



## Create trade route

POST to

    localhost:3000/api/trades?company=AAPL&shares=5



## Run with 

    $ ruby serve.rb



##  Sample .env file

    COMPOSEIO_URI='mongodb://db_user:db_password@candidate.52.mongolayer.com:10794/investing_rest_api'
    ACCESS_CONTROL_ALLOW_ORIGIN='http://localhost:3000'