#!/usr/bin/env ruby

require 'benchmark'
require './lib/foreman_httpi_client'
require './ext/net_http_gss.rb' if ENV["KERBEROS"]

HTTPI.adapter = :net_http

if ARGV[0].nil?
  puts "you must provide a Foreman URL"
  exit 1
end

Benchmark.bm do |x|
  x.report { $client = ForemanHttpiClient.new(ARGV[0]) }
  x.report { $hosts = $client.get_all_hosts }
  x.report { $all = $hosts.map { |host| $client.fetch_host_details(host) } }
end

puts "Hosts collected: #{$all.length}"
