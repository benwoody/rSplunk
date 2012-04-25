require 'faraday'
require 'faraday_middleware'

$:.unshift( File.dirname( __FILE__ ))

module Rsplunk

  VERSION = '0.3.1'

  require 'rsplunk/search'
  require 'rsplunk/client'
  require 'rsplunk/api_error'

  attr_accessor :host, :port

  # Set the Splunk server instance.  Defaults to 'localhost:8089'
  def self.set(host='localhost', port = 8089)
    $host = host
    $port = port
    "https://#{$host}:#{$port}"
  end

end
