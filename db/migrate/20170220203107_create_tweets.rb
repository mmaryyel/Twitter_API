class CreateTweets < ActiveRecord::Migration
  def change
  	create_table :tweets do |t|
      t.belongs_to :user
      t.string :description
      t.timestamps
    end
  end
end
