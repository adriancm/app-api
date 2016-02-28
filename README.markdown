# App-API 

[![Build Status](https://travis-ci.org/asfarto/app-api.svg?branch=master)](https://travis-ci.org/asfarto/app-api)
[![Code Climate](https://codeclimate.com/github/asfarto/app-api/badges/gpa.svg)](https://codeclimate.com/github/asfarto/app-api)
[![Dependency Status](https://gemnasium.com/asfarto/app-api.svg)](https://gemnasium.com/asfarto/app-api)

 [![Deploy](https://www.herokucdn.com/favicon.ico)](https://v-app-api.herokuapp.com/)
 
#### Create an awesome versioned API, secured with OAuth2 and automatically documented.

This is a basic Rails 4 application with [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper), [Grape](https://github.com/intridea/grape) & [Swagger](http://swagger.io/) for getting to API building quickly.

You can view the [live app](https://grape-doorkeeper.herokuapp.com) and the [Swagger-ui documentation](https://v-app-api.herokuapp.com/documentation). 



## Set up

First `bundle install` and `rake db:setup`

Run `rake start` to get the server running locally. It runs at [http://localhost:3001](http://localhost:3001)

## Adding to an existing application

[View how to on the wiki](https://github.com/sethherr/grape-doorkeeper/wiki/Adding-to-an-existing-application).


## Notes

Grape is mounted in [app/controllers/api](app/controllers/api), as described in the excellent [Introduction to building APIs with Grape](http://codetunes.com/2014/introduction-to-building-apis-with-grape/) by Monterail, and [part 2](http://codetunes.com/2014/grape-part-II/) of the series.

There are are other posts in the series which are worth reading, particularly [OAuth Implicit Grant with Grape, Doorkeeper and AngularJS](http://codetunes.com/2014/oauth-implicit-grant-with-grape-doorkeeper-and-angularjs/).

There is also a [Railscast on doorkeeper](http://railscasts.com/episodes/353-oauth-with-doorkeeper).

Important things in the Gemfile:

- [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) (OAuth providing)
- [grape](https://github.com/intridea/grape) (API building)
- [wine_bouncer](https://github.com/antek-drzewiecki/wine_bouncer) (Doorkeeper and Grape)
- [grape-swagger](https://github.com/tim-vandecasteele/grape-swagger) (automatically generates Swagger docs for the [auto documentation](https://grape-doorkeeper.herokuapp.com/documentation))
- [Devise](https://github.com/plataformatec/devise) (users)


Also important, but maybe not as necessary to know about:

- [rails_swagger-ui](https://github.com/d4be4st/swagger-ui_rails) (how we get swagger-ui)
- [Puma](http://puma.io/) (the web server)
- [api-pagination](https://github.com/davidcelis/api-pagination)
- [grape-active_model_serializers](https://github.com/jrhe/grape-active_model_serializers) 
- [CORS](https://github.com/cyu/rack-cors)
- [foreman](https://github.com/ddollar/foreman) (in development to manage processes)
- [Haml](http://haml.info/)
- [dotenv-rails](https://github.com/bkeepers/dotenv) (load environmental variables - .env is in .gitignore, so it isn't committed)
- [Bootstrap](http://getbootstrap.com/)
- Postgres

----

If you want to change the name of the app, swap out:

- `AppAPI` in [config/application.rb](config/application.rb)
- `app-api` in [config/database.yml](config/database.yml) (multiple instances)
- `app-api` in [config/initializers/session_store.rb](config/initializers/session_store.rb)


## Testing

Rspec and guard - run `bundle exec guard` to watch your spec files for changes and rerun tests for those files.

There is a spec for the `api/v1/me` API route and for the swagger docs to help get you started.