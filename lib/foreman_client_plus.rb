#!/usr/bin/env ruby

require 'apipie-bindings'
require './ext/net_http.rb'

class ForemanClientPlus
  def initialize(base_url)
    @api = ApipieBindings::API.new({:uri => base_url, :api_version => 2})
    @base_url = base_url
    @cookie = nil
  end

  def find_host(name)
    raw = @api.resource(:hosts).action(:index).call()['results']
    h = raw.detect {|each| each['name'] == name}
  end

  def get_all_hosts
    raw = @api.resource(:hosts).action(:index).call()['results']
    raw.map {|host| host['name']}
  end
end
