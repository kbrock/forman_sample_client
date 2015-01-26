module NetGSS
  def request(req, body = nil, &block)
    require 'rkerberos'
    require 'gssapi'
    require 'base64'
    gssapi = GSSAPI::Simple.new(@address, 'HTTP')
    token = gssapi.init_context
    req['Authorization'] ||= "Negotiate #{Base64.strict_encode64(token)}"
    super
  end
end

module Net
  class HTTP
    prepend NetGSS
  end
end
