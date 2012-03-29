module Tpauth

	VERSION = '1.0.0'

	require 'net/http'
	require 'yajl'

	class Token

		# url for Admin Auth
		@url = URI("https://identity.auth.theplatform.com/idm/web/Authentication/signIn?schema=1.0&form=json")

		def self.full(username, password)

			req = Net::HTTP::Get.new(@url.request_uri)
			req.basic_auth("#{username}", "#{password}")

			result = Net::HTTP.start(@url.hostname, @url.port, :use_ssl => @url.scheme == 'https') do |http|
			  http.request(req)
			end

			# t = Tpauth::Token.full('ben.woodall@theplatform.com', '')

			Yajl::Parser.parse(result.body)

		end

		def self.solo(username, password)
			# return only the token value
			res = Tpauth::Token.full(username,password)



		end

		def self.is_valid?
			# is the user submitted valid? Boolean response.
		end

	end

end

