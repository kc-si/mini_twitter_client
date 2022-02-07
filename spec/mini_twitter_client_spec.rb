require './lib/mini_twitter_client'
require 'debug'

RSpec.describe 'methods of mini_twitter_client class: create_tweet, update_tweet and delete_tweet' do
  it ' creates new tweet and delete it ' do
    name = 'Johan'
    email = 'johan@johan.com'
    message = 'Test tweet :)'

    def mini_twitter_client
      MiniTwitterClient.new
    end

    response = mini_twitter_client.create_tweet(name, email, message)

    response = mini_twitter_client.update_tweet(response[:data][:id], 'Henry', 'henry@test.com', 'Hi twitter' )

    response = mini_twitter_client.delete_tweet(response[:data][:id])

    expect(response[:status]).to eq(204)
  end
end
