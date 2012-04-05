require 'rsplunk/auth'

module Rsplunk

	class Search

		# Dirty.  Creates a list of jobs currently running on Splunk server.
		# *query enters as an array.  Collection will be iterated through with
		# the list of queries.  If no valid queries exist, returns an empty array [].

		# To Do: Only accept valid queries
		#        Memoization
		#
		def query_jobs(*query)
			res = Hpricot(Rsplunk::Auth.splunk_ssl_post_request("/services/search/jobs/",
																	nil,
																  {'authorization' => "Splunk #{$session_token}"}))

			if query == []
				res
			else
				(res/"//entry").collect do |list|
					query.collect do |item|
						(list/"//#{item}").inner_html
					end
				end
			end

			# Author: (item/"//name")
			# SID: (item/"//search")
			# Query: (item/"//title")
			# Published: (item/"//published")
			# Updated: (item/"//updated")
			# Total Jobs: (res/"//opensearch:totalresults")
			# Items/Page: (res/"//opensearch:itemsperpage")
			# Start Index: (res/"//opensearch:startindex")

		end

		def create_job(query)
		end

		def delete_job(sid)
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
