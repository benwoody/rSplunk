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

end
