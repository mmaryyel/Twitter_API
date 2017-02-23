class Tweet < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user

  def self.tweets_updated?(tweet_list)
    Tweet.first.created_at != tweet_list.first.created_at 
  end
end
