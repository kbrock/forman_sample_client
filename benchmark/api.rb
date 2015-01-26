#!/usr/bin/env ruby

require 'benchmark'
require './lib/foreman_api_client'
require './ext/net_http_gss.rb' if ENV["KERBEROS"]

if ARGV[0].nil?
  puts "you must provide a Foreman URL"
  exit 1
end

Benchmark.bm do |x|
  x.report { $client = ForemanApiClient.new(ARGV[0]) }
  x.report { $hosts = $client.get_all_hosts }
  # NOTE: find_host != fetch_host_details
  x.report { $all = $hosts.collect {|host| $client.fetch_host_details(host) } }
end

puts "Hosts collected: #{$all.length}"
