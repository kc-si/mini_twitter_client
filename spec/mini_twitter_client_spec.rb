require './lib/mini_twitter_client'
require 'debug'

RSpec.describe 'methods of mini_twitter_client class: create_tweet, update_tweet and delete_tweet' do
  it ' creates new tweet and delete it ' do
    name = 'Johan'
    email = 'johan@johan.com'
    message = 'Test tweet :)'

    mini_twitter_client = MiniTwitterClient.new

    response = mini_twitter_client.create_tweet(name, email, message)

    response = mini_twitter_client.update_tweet('Henry', 'henry@test.com', 'Hi twitter', response[:data].id)

    response = mini_twitter_client.delete_tweet(response[:data].id)

    expect(response[:status]).to eq(204)
  end
end
