module Rsplunk
	module Search

		# Returns an XML with all of the current running jobs
		def list_jobs(options = {})
			# options[:output_mode] ||= 'json'
			response = connection.get do |req|
				req.url ('search/jobs')
				req.body = options
			end
			return_error_or_body(response, response)
		end

		# Create a job
		#
		# 'query' is the search string you are passing to Splunk
		# 'options' can be found at http://docs.splunk.com/Documentation/Splunk/4.2.2/RESTAPI/RESTsearch#POST_search.2Fjobs
		#
		def create_job(query, options={})
			options[:earliest_time] ||= '-15m'
			[:earliest_time, :latest_time, :time].each { |t| options[t] = format_time(options[t]) if options[t] }
			response = connection.post do |req|
				req.url 'search/jobs'
				req.body = { :search => "search #{query}" }.merge(options)
			end
			return_error_or_body(response, response.body)
		end

		# Return results from a job using the job SID
		def job_results(sid)
			response = connection.get("search/jobs/#{sid}/results")
			return_error_or_body(response, response.body)
		end

		def delete_job(sid)
			response = connection.delete("search/jobs/#{sid}")
			return_error_or_body(response, response.body)
		end


		private

		def format_time(time)
    	time.is_a?(Time) ? time.strftime('%Y-%m-%dT%H:%M:%S%z') : time.to_s
  	end

	end
end
