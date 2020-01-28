require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative("./models/pizza_order.rb")
also_reload("./models/*")

# This controller will return some HTML that shows
# all of the pizza orders in a nice list.
get '/pizza-orders' do
  # we first need to get all the pizza orders.
  @orders = PizzaOrder.all
  # then we will pass the pizza orders into a global variable.
  erb(:index)
end

# This route should return a html page that has a form to
# create new pizza orders.
get '/pizza-orders/new' do
  erb(:new)
end

# This route should return some html that shoes a single
# pizza order
get '/pizza-orders/:id' do
  # Get pizza order - by calling find on PizzaOrder
  # and by passing in the id we've got from params.
  # Render the show page for that order.
  @order = PizzaOrder.find(params[:id])
  erb(:show)
end

post '/pizza-orders/:id' do
  @order = PizzaOrder.new(params)
  @order.update
  redirect to('/pizza-orders')
end

# This route should accept POST requests on pizza-orders
# then take the posts parameters
# then create a new pizza order
post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save
  erb(:create)
end

post '/pizza-orders/:id/delete' do
  @order = PizzaOrder.find(params[:id])
  @order.delete()
  redirect to('/pizza-orders')
end

get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end
