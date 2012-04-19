$:.unshift( File.dirname( __FILE__ ))

require 'net/https'
require 'rubygems'
require 'hpricot'
require 'json'
require 'cgi'

module Rsplunk

  VERSION = '0.1.1'

  require 'rsplunk/auth'
  require 'rsplunk/search'

  attr_accessor :host, :port

  # Set the Splunk server instance.  Defaults to 'localhost:8089'
  def self.set(host='localhost', port = 8089)
    @host = host
    @port = port
    "#{@host}, #{@port}"
  end

  # Create an SSL POST
  def self.splunk_ssl_post_request(path, data = nil, headers = nil)
    http = Net::HTTP.new(@host, @port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.post(path, data, headers).body
  end
  # Create and SSL GET
  def self.splunk_ssl_get_request(path, headers = nil)
    http = Net::HTTP.new(@host, @port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.get(path, headers).body
  end
  # Create an SSL DELETE
  def self.splunk_ssl_delete_request(path, headers = nil)
  	http = Net::HTTP.new(@host, @port)
  	http.use_ssl = true
  	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  	http.delete(path, headers).body
  end

end
