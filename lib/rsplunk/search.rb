require 'rsplunk/auth'

module Rsplunk

	class Search

		# To Do: Only accept valid queries
		#        Memoization

		# List current jobs
		def query_jobs(*query)
			if query == []
				search_request
			else
				(search_request/"//entry").collect do |list|
					query.collect do |item|
						(list/"//#{item}").inner_html
					end
				end
			end

		end

		# Create a search job
		def create_job(query)
			search = "search #{query}"
			res = Hpricot(Rsplunk.splunk_ssl_post_request("/services/search/jobs",
																									"search=search #{CGI::escape(search)}",
																									{'authorization' => "Splunk #{$session_token}"}))
			(res/"//sid").inner_html
		end

		# Return results from a job using the job SID
		def job_results(sid)
			res = Hpricot(Rsplunk.splunk_ssl_get_request("/services/search/jobs/#{sid}/results",
                             											 {'authorization' => "Splunk #{$session_token}"}))

  	end

  	# Delete jobs using the job SID
		def delete_job(sid)
			res = Hpricot(Rsplunk.splunk_ssl_delete_request("/services/search/jobs/#{sid}",
                            													{'authorization' => "Splunk #{$session_token}"}))
		end

	end

	private

	def search_request
		Hpricot(Rsplunk.splunk_ssl_post_request("/services/search/jobs/",
																						nil,
															  						{'authorization' => "Splunk #{$session_token}"}))
	end

end
