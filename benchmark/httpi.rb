#!/usr/bin/env ruby

require 'benchmark'
require './lib/foreman_client'

if ARGV[0].nil?
  puts "you must provide a Foreman URL"
  exit 1
end

Benchmark.bm do |x|
  x.report { $client = ForemanClient.new(foreman) }
  x.report { $hosts = $client.get_all_hosts }
  x.report { $hosts.each {|host| $client.make_api_request("hosts/#{host}") } }
end
