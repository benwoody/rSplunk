require 'rsplunk/auth'

module Rsplunk

	class Search

		# Dirty.  Creates a list of jobs currently running on Splunk server
		def list_jobs(*query)
			res = Hpricot(Rsplunk::Auth.splunk_ssl_post_request("/services/search/jobs/",
																	nil,
																	{'authorization' => "Splunk #{$session_token}"}))
			# res.to_json
			if query == []
				res
			else
				(res/"//entry").collect do |list|
					query.collect do |item|
						(list/"//#{item}").inner_html
					end
				end
			end


			# (res/"//entry").collect do |item|
			# 	puts "Author: #{(item/"//name").inner_html}"  # Return query author
			# 	puts "SID: #{(item/"//search").inner_html}"  # Return SID
			# 	puts "Query: #{(item/"//title").inner_html}"  # Return query
			# 	puts "Published: #{(item/"//published").inner_html}"
			# 	puts "Updated: #{(item/"//updated").inner_html}"
			# 	puts "-+-+-+-+-+-+-+-+-+-+-+-+-+-"
			# end
			# puts "Total Jobs: #{(res/"//opensearch:totalresults").inner_html}"
			# puts "Items/Page: #{(res/"//opensearch:itemsperpage").inner_html}"
			# puts "Start Index: #{(res/"//opensearch:startindex").inner_html}"

		end

		def create_job(query)
		end




	end

end


 #  {elem <published> "2012-04-05T07:19:05.000-07:00" </published>}
 # {elem <updated> "2012-04-05T07:19:07.000-07:00" </updated>}

# <entry>

#   {elem <opensearch:totalresults> "391" </opensearch:totalResults>}
#   "\n  "
#   {elem <opensearch:itemsperpage> "0" </opensearch:itemsPerPage>}
#   "\n  "
#   {elem <opensearch:startindex> "0" </opensearch:startIndex>}



# (doc/"//sessionkey").inner_html
# <s:dict>
#       <s:key name="sid">
#       "scheduler_YnJpYW4uamFjb2J5__search_TVBTX0FwcF9FcnJvckxvZ19EYXRhX1RydW5jYXRpb25fQWxlcnQ_at_1333632060_694e194ec413220f"
#       </s:key>}

   # {elem
   #  <title>
   #  "search  sourcetype=\"release-log\" earliest=-5m | stats count , avg(response_time) as \"Average ResponseTime\" by account_
   #  </title>}


   #  <author>
   #  "\n      "
   #  {elem <name> "andy.litzinger" </name>}
   #  "\n    "
   #  </author>}
