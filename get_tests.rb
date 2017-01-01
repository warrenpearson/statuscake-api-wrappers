#!/usr/bin/env ruby

require 'statuscake'
require 'json'

# Retrieve all tests, with optional filter.
class GetTests
  def initialize
    api_key = ENV['SC_API_KEY']
    user_id = ENV['SC_USER_ID']
    @client = StatusCake::Client.new(API: api_key, Username: user_id)
  end

  def get_tests(filter)
    test_arr = []
    tests = @client.tests
    tests.each do |t|
      next if filter && !t['WebsiteName'].match(filter)
      puts "#{t['TestID']}: #{t['WebsiteName']}"
      test_arr << t['TestID']
    end

    test_arr.each do |test_id|
      dump_details(test_id)
    end
  end

  def dump_details(test_id)
    details = @client.tests_details(TestID: test_id)
    detail_json = JSON.pretty_generate(details)
    File.open("./#{test_id}.json", 'w') { |file| file.write(detail_json) }
  end
end

filter = ARGV[0]
gt = GetTests.new
gt.get_tests(filter)
