module Rsplunk

  class Auth

    # Set Splunk server.  Users 'localhost:8089' if none provided
    def initialize(host='localhost', port = 8089, user, pass)
      $host = host
      $port = port
      @user = user
      @pass = pass
      session_token
    end

    attr_accessor :host, :port
    attr_reader :user, :pass

    # Initial SSL request
    def self.splunk_ssl_post_request(path, data = nil, headers = nil)
      http = Net::HTTP.new($host, $port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.post(path, data, headers).body
    end

    def self.splunk_ssl_get_request(path, headers = nil)
      http = Net::HTTP.new($host, $port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.get(path, headers).body
    end

    # Grab token with username and password
    def create_token
      doc = Hpricot(Rsplunk::Auth.splunk_ssl_post_request("/services/auth/login",
                                                          "username=#{@user}&password=#{@pass}"))
      (doc/"//sessionkey").inner_html
    end

    def session_token
      $session_token ||= create_token
    end

  end

end
