This project, such as it is, allows you to log in to a Twitter account, and then search the tweets that would be
available to you via the Twitter API's search/tweets function.

Beyond that, it's not very exciting, and it's largely an excuse for me to learn Sinatra, because not everything
really needs the 200 kilogram gorilla that is Rails. :-)

It's structured as two separate 'apps' under Sinatra -- one for the logging in and setting up of a session, one for the
search page. I think Sinatra's terminology here is a little strange, calling them different apps, but see the first bullet
under Known Issues below.

You should be able to start the app with:

    bundle exec rackup -s thin -p 4567

Known Issues:

* Naming things is hard. "Sinatra-Thingy", for example, is kind of a lame name.
* There's no testing for either the search verb or the javascript. I probably could set something up involving
  replayed data and so on, but it hasn't happened at this point.

Dependencies:

* Ruby 2.0.0-p195 or greater
* Bundler
* Sinatra 1.4.3
* Sinatra Contrib GEM 1.4.0 (for JSON magic)
* Slim 2.0 (a templating language similar to but even cleaner than HAML)
* OAuth 0.4.7 (for Twitter authorization)
* Yajl as the JSON parser of choice

For testing:
* RSpec
* Shoulda

Michael Shappe<br/>
<mshappe@camelopard-consulting.com>