require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza.rb')

# INDEX --- READ - all
get '/pizzas' do
  @pizzas = Pizza.all()
  erb(:index)
end

# NEW --- CREATE - get form -- has to be listed above the show route, otherwise it will think 'new' is an id. Sinatra reads top to bottom
get '/pizzas/new' do
  erb(:new)
end

# SHOW --- READ - find by id
get '/pizzas/:id' do
  @pizza = Pizza.find( params[:id] )
  erb(:show)
end

# CREATE --- CREATE - submit form

post '/pizzas' do
 @pizza = Pizza.new( params ) #the params hash is capable of passing directly to the Pizza class - it's not a straightforwars hash, it's a method that will be interpreted the right way - don't worry about the keys needing to be a string. 
 @pizza.save
 erb(:create)
end

# EDIT --- UPDATE - get form

get '/pizzas/:id/edit' do
  @pizza = Pizza.find(params[:id])
  erb(:edit)
end

# UPDATE --- UPDATE - submit form

post '/pizzas/:id' do
  @pizza = Pizza.find(params[:id])
  @pizza.first_name = params[:first_name]
  @pizza.last_name = params[:last_name]
  @pizza.topping = params[:topping]
  @pizza.quantity = params[:quantity]
  @pizza.update
  redirect to("/pizzas/#{@pizza.id}")
#could have just made a new pizza object and updated it - because the id is getting passed through as a param, there shouldn't be any problem with it 
end

# DESTROY --- DELETE
post '/pizzas/:id/delete' do
  @pizza = Pizza.find(params[:id])
  @pizza.delete
  erb(:destroy)
  #better to do redirect to('/pizzas')?
end

