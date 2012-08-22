= rSplunk

== DESCRIPTION:

rSplunk is a Splunk (http://www.splunk.com) API wrapper.  To use this gem, you will need access
to a Splunk server.

=== To create a Splunk instance
Rsplunk.set('HOST', PORT)
=> "https://HOST:PORT"

=== To create a Splunk session
splunk = Rsplunk::Client.new(:username => 'USERNAME', :password => 'PASSWORD')
=> #<Rsplunk::Client:0x8b800f8 @pass="PASSWORD", @user="USERNAME">

=== To view current query jobs:
splunk.list_jobs

=== To create a job:
splunk.create_job('search SEARCH TERM', options)
=> "1334848433.7828"

Where, "1334848433.7828" is the Search ID returned from the job.

I elected not to append 'search' automagically to the beginning of a job because you may need to create
different jobs other than a direct 'search'.  Splunk UI does this automatically when using its interface.
So a valid 'search' job would look like 'search 404:error host="www.benwoodall.com"'

By default, a search with no 'earliest_time' option is set to '-15m' to only search the last 15 minutes.
To change this:
splunk.create_job('search SEARCH TERM', ":earlist_time => '-60m'")

Available options can be found at:
http://docs.splunk.com/Documentation/Splunk/4.2.2/RESTAPI/RESTsearch#POST_search.2Fjobs

=== To list job results:
splunk.job_results(res)
=> XML results

== REQUIREMENTS:

Access to a working Splunk environment.
* faraday
* faraday_middleware

== INSTALL:

gem install rsplunk

== Upcoming Features:
* include ALL THE ENDPOINTS!
* move to httparty

== Contributing to rSplunk

* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== LICENSE:

(The MIT License)

Fork it. Fix it. Push it. Pull it.
