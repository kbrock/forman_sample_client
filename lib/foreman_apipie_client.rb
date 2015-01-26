require 'apipie-bindings'

class ForemanApipieClient
  def initialize(base_url)
    @api = ApipieBindings::API.new(:uri => base_url, :api_version => 2, :apidoc_cache_name => 'benchmark')
    @base_url = base_url
  end

  def fetch_host_details(host)
    @api.resource(:hosts).action(:show).call(host)['results']
  end

  def get_all_hosts
    @api.resource(:hosts).action(:index).call()['results']
  end
end
