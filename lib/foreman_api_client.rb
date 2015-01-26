require 'foreman_api'

class ForemanApiClient
  def initialize(base_url)
    @base_url = base_url
  end

  def connect(resource)
    resource.new(:base_url => @base_url, :verify_ssl => false)
  end

  def fetch_host_details(host)
    connect(ForemanApi::Resources::Host).show(host).first
  end

  def get_all_hosts
    connect(ForemanApi::Resources::Host).index.first["results"]
  end
end
