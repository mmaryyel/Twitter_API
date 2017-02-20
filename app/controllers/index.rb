get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :index
end

post '/fetch' do
  username = params[:username]
  
  redirect to("/#{username}")
end

get '/:handle' do
	@username = params[:handle]
	@tweets = CLIENT.user_timeline(@username)

  erb :all_tweets
end