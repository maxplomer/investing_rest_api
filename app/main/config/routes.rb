# See https://github.com/voltrb/volt#routes for more info on routes

get "/api/trades", controller: 'trades', action: 'index'
post "/api/trades", controller: 'trades', action: 'create'
get "/api/my_trades", controller: 'trades', action: 'my_trades'

# client '/about', action: 'about'

# Routes for login and signup, provided by user_templates component gem
# client '/signup', component: 'user_templates', controller: 'signup'
# client '/login', component: 'user_templates', controller: 'login', action: 'index'
# client '/password_reset', component: 'user_templates', controller: 'password_reset', action: 'index'
# client '/forgot', component: 'user_templates', controller: 'login', action: 'forgot'
# client '/account', component: 'user_templates', controller: 'account', action: 'index'

# The main route, this should be last. It will match any params not
# previously matched.
# client '/', {}
