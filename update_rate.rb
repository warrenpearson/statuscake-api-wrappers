#!/usr/bin/env ruby

require 'statuscake'

# Update a test's CheckRate interval in seconds.
class UpdateRate
  def initialize
    api_key = ENV['SC_API_KEY']
    user_id = ENV['SC_USER_ID']
    @client = StatusCake::Client.new(API: api_key, Username: user_id)
  end

  def update(test_id, rate)
    result = @client.tests_update(TestID: test_id, CheckRate: rate)
    puts result.inspect
  end
end

test_id = ARGV[0]
rate    = ARGV[1]

unless test_id && rate
  puts 'Please supply a test_id and a rate'
  exit
end

UpdateRate.new.update(test_id, rate)
