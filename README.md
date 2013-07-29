This project, such as it is, allows you to log in to a Twitter account, and then search the tweets that would be
available to you via the Twitter API's search/tweets function.

Beyond that, it's not very exciting, and it's largely an excuse for me to learn Sinatra, because not everything
really needs the 200 kilogram gorilla that is Rails. :-)

It's structured as two separate 'apps' under Sinatra -- one for the logging in and setting up of a session, one for the
search page. I think Sinatra's terminology here is a little strange, calling them different apps, but see Known Issues
below.

Known Issues:

* Thingy is a lame name. Naming things is hard.

Dependencies:

* Ruby 2.0.0-p195 or greater
* Bundler
* Sinatra 1.4.3
* Sinatra Contrib GEM 1.4.0 (for JSON magic)
* Slim 2.0 (a templating language similar to but even cleaner than HAML)
* YAJL (also for JSON magic)
* OAuth 0.4.7 (for Twitter authorization)

For testing:
* RSpec
* Shoulda