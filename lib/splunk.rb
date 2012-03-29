module Splunk

  VERSION = '0.2.1'

  require 'net/https'
  require 'rubygems'
  require 'hpricot'

  class Auth
    HOST = 'tpsplunk'
    PORT = 8089

    def splunk_ssl_post_request(path, data = nil, headers = nil)
      http = Net::HTTP.new(HOST, PORT)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.post(path, data, headers).body
    end

    def session_key
      @session_key ||= load_session_key
    end

    def load_session_key(user, pass)
      doc = Hpricot(splunk_ssl_post_request("/services/auth/login", "username=#{user}&password=#{pass}"))
      (doc/"//sessionkey").inner_html
    end

  end

client = Splunk::Auth.new
out = client.load_session_key
puts out
