---
layout: bento
title: 7web | Week 1
---

Seven Web Frameworks in Seven Weeks, Week 1: Sinatra
===================

Week 1, Day 1
--------------------------
- set up repository [https://github.com/drblinken/7web](https://github.com/drblinken/7web)
- added rvm setup, see http://drblinken.github.io/bentos/rvm.html
- added Gemfile
- used transpec gem to automatically update rspec to new expect() syntax: https://github.com/yujinakayama/transpec
- added the db to gitignore

### Source Code

    /hello - hello world
    /crud - simple crud rest backend using data mapper

### Links
* W3C http method definitions http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html
* W3C http return code definitions [http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)

### Self-Study

#### Find:
* Sinatra doc: [http://www.sinatrarb.com/documentation.html](http://www.sinatrarb.com/documentation.html)
* DataMapper: [http://datamapper.org](http://datamapper.org)

#### Do:
* test was already there!
* added creation_date to Bookmark
* handler for bookmarks sorted by creation_date

## Urls to open
http://localhost:4567/bookmarks/1

Week 1, Day 2
----

Templating languages: erb, slim (a bit like haml but cleaner), mustache (with {} like liquid, no logic in the template).

### Self-Study

#### Find:

* Templating alternatives: [There are quite a lot.](http://www.sinatrarb.com/intro.html#Available%20Template%20Languages)

#### Do:

* does respond_with work with slim and mustache?

Does work with slim, apparently not with mustache, maybe because it's not known to Sinatra? [http://www.sinatrarb.com/contrib/respond_with.html](http://www.sinatrarb.com/contrib/respond_with.html)

Week 1, Day 3
----
### Self-Study

#### Find:

* [Documentation for finding a custom route matcher](http://www.sinatrarb.com/intro.html#Custom%20Route%20Matchers)
* Real-World Apps that use Sinatra [are listed on the sinatra page](http://www.sinatrarb.com/wild.html), Travis, LinkedIn,

* [Pedro Belo](https://pedro.herokuapp.com/past/2012/9/12/on_rails_sinatra_and_picking_the_right_tool_for_the_job/) writes about when to use Rails (Web App) and when Sinatra (API); and makes a point that maybe you shouldn't mix the two in one application.

#### Do:

* create and retrieve bookmarks with tags with curl:
in /sinatra/validation

    curl -d "url=http://xxx.de&title=INFRA&tagsAsString=A,B,C" http://localhost:4567/bookmark

    curl http://localhost:4567/bookmarks/A/B

    curl -i -H "Accept: application/json" http://localhost:4567/bookmarks





* write test to verify updating of bookmarks with tags: Already present:
"Bookmarking App creates and updates a bookmark with tags"

* add tag support to the view templates of your choice.

...learned more about curl

Dump Headers

    curl -D headers http://localhost:4567

send accept type

    curl -H "Accept: application/json" http://localhost:4567/bookmarks

and get header info

    curl -i -H "Accept: application/json" http://localhost:4567/bookmarks

more to copy

   curl  -H "Accept: text/html" http://localhost:4567/bookmarks
-H "Accept: application/json"

- run a single example in rspec

    rspec app_test.rb -e "gets a single bookmark in JSON"

Added Capybara, see [http://blog.orenyk.com/2014/03/11/testing-sinatra-apps-with-rspec-and-capybara/](http://blog.orenyk.com/2014/03/11/testing-sinatra-apps-with-rspec-and-capybara/)
