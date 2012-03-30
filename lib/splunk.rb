$:.unshift( File.dirname( __FILE__ ))

require 'net/https'
require 'rubygems'
require 'hpricot'

module Splunk

  VERSION = '0.1.1'

  require 'splunk/auth'

end
