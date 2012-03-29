module Splunk

  VERSION = '0.5.0'

  require 'net/https'
  require 'rubygems'
  require 'hpricot'

  class Auth

    HOST = 'tpsplunk'
    PORT = 8089

    # Initial SSL request
    def splunk_ssl_request(path, data = nil, headers = nil)
      http = Net::HTTP.new(HOST, PORT)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.post(path, data, headers).body
    end

    # Grab token with username and password
    def token(user, pass)
      doc = Hpricot(splunk_ssl_post_request("/services/auth/login", "username=#{user}&password=#{pass}"))
      (doc/"//sessionkey").inner_html
    end

  end

end
