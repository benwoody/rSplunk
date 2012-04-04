require 'rsplunk/auth'

module Rsplunk

	class Search

		# Dirty.  Creates a list of jobs currently running on Splunk server
		def list_jobs
			res = Hpricot(Rsplunk::Auth.splunk_ssl_post_request("/services/search/jobs/",
																	nil,
																	{'authorization' => "Splunk #{$session_token}"}))
		end

		def create_job(query)
		end




	end

end
