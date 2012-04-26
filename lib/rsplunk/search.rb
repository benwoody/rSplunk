module Rsplunk
	module Search

    # RETURN ALL THE JOBS!
		#
		# Returns an XML with all of the current running jobs
		# Valid options for this are for output format:
		# :output_mode => 'csv | raw | xml | json'
		def list_jobs(options = {})
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
		def create_job(query, options={})
			search = "#{query}"
			options[:earliest_time] ||= '-15m'
			[:earliest_time, :latest_time, :time].each { |t| options[t] = format_time(options[t]) if options[t] }
			response = connection.post do |req|
				req.url 'search/jobs'
				req.body = { :search => "#{search}" }.merge(options)
			end
			return_error_or_body(response, response.body["response"]["sid"])
		end


		# Return results
		#
		# Gives the results from a job using the job SID.
		# Valid options for this are for output format:
		# :output_mode => 'csv | raw | xml | json'
	  def job_results(sid, options = {})
			response = connection.get do |req|
				req.url "search/jobs/#{sid}/results"
				req.body = options
			end
			return_error_or_body(response, response.body)
		end

		# Delete job
		#
		# Delete a running or saved job using the job SID
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
