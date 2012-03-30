module Rsplunk

  class Auth

    def initialize(host, port)
      @host = host
      @port = port
    end

    attr_accessor :host, :port

    # Initial SSL request
    def splunk_ssl_request(path, data = nil, headers = nil)
      http = Net::HTTP.new(@host, @port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.post(path, data, headers).body
    end

    # Grab token with username and password
    def token(user, pass)
      doc = Hpricot(splunk_ssl_request("/services/auth/login", "username=#{user}&password=#{pass}"))
      (doc/"//sessionkey").inner_html
    end

  end

end
