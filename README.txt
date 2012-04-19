= rSplunk

== DESCRIPTION:

This is a gem to facilitate Splunk searches and indexing.

== SYNOPSIS:

require 'rsplunk'

=== To create a Splunk instance
foo = Rsplunk.set('HOST', PORT)
=> "@host, @port"

=== To create a Splunk session
session = Rsplunk::Auth.new('username', 'password')
=> #<Rsplunk::Auth:0x1080daf8 @pass="password", @user="username">

Appending the 'session_token' method will give you your token:
session.session_token
=> "66f8ee2ab56a2e30d3a016f6b78e50ce"

=== To view current query jobs:
bar = Rsplunk::Search.new
bar.query_jobs

This will bring back a very unsexy XML package for you.

'query_jobs' can take arguements to return certain XML parameters:

For example:
bar.query_jobs("name", "published", "title")

will return the owner, published date, and query string for all current running jobs.

=== To create a job:
res = bar.create_job("Hello, World")
=> "1334848433.7828"

Where, "1334848433.7828" is the Search ID returned from the job.

=== To list job results:
bar.job_results(res)
=> XML results

== REQUIREMENTS:

Access to a working Splunk environment.

== INSTALL:

gem install rsplunk

== Upcoming Features:
* Provide a timeline for Search.  As of now, it sets to 'All Time'.
* Credentials providing: delete a query

== Contributing to rSplunk

* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== LICENSE:

(The MIT License)

Copyright (c) 2012 Ben Woodall

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
