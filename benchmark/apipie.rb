#!/usr/bin/env ruby

require 'benchmark'
require './lib/foreman_client_plus'

if ARGV[0].nil?
  puts "you must provide a Foreman URL"
  exit 1
end

Benchmark.bm do |x|
  x.report { $client = ForemanClientPlus.new(ARGV[0])    }
  x.report { $hosts = $client.get_all_hosts               }
  x.report { $all = []; $hosts.each {|host| $all << $client.fetch_host_details(host)} } # find_host != fetch_host_details
end

puts "Hosts collected: #{$all.length}"
