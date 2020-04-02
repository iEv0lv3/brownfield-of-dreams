# Brownfield Of Dreams

This is the base repo for a brownfield project used at Turing for Backend Mod 3. This application utilizes multiple APIs to create a dynamic content orgainization system. As a response to COVID-19, this web application will help aspiring programmers utilize some of Turing's resources without breaking thier bank. 

**API's utilized**

1. Github API
2. Youtube API

### About the Project

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

## Local Setup

First you'll need to setup an API key with YouTube and have it defined within `ENV['YOUTUBE_API_KEY']`. There will be one failing spec if you don't have this set up.

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

## Sign-in & Connect to Github
[First, Register for an account](https://imgur.com/a/0kb2Wbz) 

[Next, Click "Connect to github"](https://imgur.com/a/tbyMSn2)

[Authorize Turing Turorials to connect to github](https://imgur.com/a/vfLnDB5)

## Find & invite friends through github 
Click link 'invite friends
[![Screen-Shot-2020-04-02-at-11-26-52-AM.png](https://i.postimg.cc/2jvVQKbB/Screen-Shot-2020-04-02-at-11-26-52-AM.png)](https://postimg.cc/qgJJ0QGk)

Search for your friend on github, if they have a public email, Turing Tutorials will automatically send them an invitation to register!
[![Screen-Shot-2020-04-02-at-11-51-25-AM.png](https://i.postimg.cc/WzhKZHwW/Screen-Shot-2020-04-02-at-11-51-25-AM.png)](https://postimg.cc/8fgtQw3M)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
