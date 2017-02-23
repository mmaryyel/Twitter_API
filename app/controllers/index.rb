get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :index
end

post '/fetch' do
  username = params[:username]
  
  redirect to("/#{username}")
end



get '/:username' do
  # Se crea un User si no existe en la base de datos de lo contrario trae de la base al usuario. 
  @username = params[:username]
  user = User.find_by(name: @username)
 
  if user
  	user
  else
    user = User.create(name: @username)
  end


  # if  user.tweets.empty?# La base de datos no tiene tweets?  
  #   # Pide a Twitter los últimos tweets del usuario y los guarda en la base de datos
  #   @tweets = CLIENT.user_timeline(@username)
  #   @tweets.each do |tweet|
  #     user.tweets << Tweet.create(description: tweet.text, created_at: tweet.created_at)
  #   end
  #end
  @tweet_list = CLIENT.user_timeline(@username)
  if Tweet.tweets_updated?(@tweet_list)	
  	puts "*" * 30
  	puts "INSIDE IF"
    db_tweet = Tweet.first.created_at
    new_tweets = @tweet_list.select { |tweet| db_tweet < tweet.created_at }
    new_tweets.each do |tweet|
    	user.tweets << Tweet.create(description: tweet.text, created_at: tweet.created_at)
    end
  end

  # Se hace una petición por los ultimos 10 tweets a la base de datos. 
  @ten_tweets = user.tweets.last(10)

  erb :all_tweets
end