#!/usr/bin/env ruby

require 'statuscake'
require 'json'

# Check that the check rate is set to
# 60 seconds for most status checks.
class RateChecker
  def initialize
    api_key = ENV['SC_API_KEY']
    user_id = ENV['SC_USER_ID']
    @client = StatusCake::Client.new(API: api_key, Username: user_id)
  end

  def check
    ids = test_ids
    ids.each do |id, name|
      get_rate(id, name)
    end
  end

  def test_ids
    ids   = {}
    tests = @client.tests
    tests.each do |test|
      ids[test['TestID']] = test['WebsiteName']
    end
    ids
  end

  def get_rate(test_id, name)
    details = @client.tests_details(TestID: test_id)
    if details['CheckRate'].to_i != 60
      puts "#{test_id} / #{name}: #{details['CheckRate']}"
    end
  end
end

RateChecker.new.check
