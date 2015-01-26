require 'json'
require 'httpi'

HTTPI.log = false

class ForemanHttpiClient
  def initialize(base_url)
    @base_url = base_url
  end

  def make_api_request(path)
    # hit the API
    url = "#{@base_url}/api/#{path}"

    request = HTTPI::Request.new(url)
    request.auth.ssl.verify_mode = :none
    request.auth.gssnegotiate if ENV["KERBEROS"]


    response = HTTPI.get(request)
    response.body
  end

  def get_all_hosts
    raw = make_api_request('hosts')
    json_hosts = JSON.parse(raw)
    json_hosts.map { |host| host['host']['name'] }
  end

  def fetch_host_details(host)
    make_api_request("hosts/#{host}")
  end
end
