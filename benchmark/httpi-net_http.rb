#!/usr/bin/env ruby

require 'benchmark'
require './lib/foreman_client'
require './ext/net_http.rb'

HTTPI.adapter = :net_http

if ARGV[0].nil?
  puts "you must provide a Foreman URL"
  exit 1
end

Benchmark.bm do |x|
  x.report { $client = ForemanClient.new(ARGV[0]) }
  x.report { $hosts = $client.get_all_hosts }
  x.report { $all = []; $hosts.each {|host| $all << $client.make_api_request("hosts/#{host}") } }
end

puts "Hosts collected: #{$all.length}"
