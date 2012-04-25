require 'forwardable'

module Rsplunk

  class Client
    extend Forwardable

    include Search

    attr_accessor :user, :pass

    # Create a Splunk session using basic_auth parameters.
    #
    # Example:
    # client = Rsplunk::Client.new(:username => 'your_username', :password => 'your_password')
    def initialize(options={})
      @user  = options[:username]
      @pass  = options[:password]
    end

    # Sets up the initial connection to your Splunk server
    def connection
      params = {}
      params[:username] = @user if @user
      params[:password] = @pass if @pass
      @connection ||= Faraday::Connection.new(:url => api_url, :ssl => { :verify => false },
                                              :params => params, :headers => default_headers) do |builder|
        builder.request  :url_encoded
        builder.response :xml
        builder.adapter  :net_http
        builder.basic_auth(@user, @pass)
      end
    end

    # This is created in Splunk.set
    def api_url
      "https://#{$host}:#{$port}/services/"
    end

    # Sexy error handling
    def return_error_or_body(response, response_body)
      if response.status.to_s =~ /20./
        response_body
      else
        raise Rsplunk::APIError.new(response, response.body)
      end
    end

    private

    def default_headers
      headers = {
        :user_agent => "rSplunk"
      }
    end

  end

end
