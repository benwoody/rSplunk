$:.unshift( File.dirname( __FILE__ ))

require 'net/https'
require 'rubygems'
require 'hpricot'
require 'json'

module Rsplunk

  VERSION = '0.1.1'

  require 'rsplunk/auth'
  require 'rsplunk/search'

  class Base

  	attr_accessor :attrs
  	alias :to_hash :attrs

  	def self.lazy_attr_reader(*attrs)
  		attrs.each do |attribute|
  			class_eval do
  				define_method attribute do
  					@attrs[attribute.to_s]
  				end
  			end
  		end
  	end

  	def initialize(attrs={})
  		@attrs = attrs.dup
  	end

  	def [](method)
  		self.__send__(method.to_sym)
  	rescue NoMethodError
  		nil
  	end

  end

end
