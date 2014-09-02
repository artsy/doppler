Deploying Doppler
=================

Doppler is typically deployed to Heroku.

#### Heroku App

```
heroku apps:create doppler-staging
```

#### Environment Settings

Add the following environment settings. The sample values below are for a staging deployment.

* ARTSY_API_URL=https://stagingapi.artsy.net
* ARTSY_API_CLIENT_ID=<Artsy API Client ID>
* ARTSY_API_CLIENT_SECRET=<Artsy API Client Secret>

```
heroku config:add ARTSY_API_URL=https://api.artsy.net ARTSY_API_CLIENT_ID=... ARTSY_API_CLIENT_SECRET=... --app=doppler-staging
```

Generate a SECRET_KEY_BASE and set the Rails environment.

```
$ ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"
eeaa792c0329...
```

```
heroku config:add RAILS_ENV=staging SECRET_KEY_BASE=eeaa792c0329... --app=doppler-staging
```

You can use a key from a demo app created on [developers-staging.artsy.net](https://developers-staging.artsy.net). Note that staging is rebuilt nightly with production data, and your application will be deleted. If you need a persistent application, create it on [developers.artsy.net](http://developers.artsy.net) - it will be available on staging within 24 hours.

#### Google Analytics

Configure Google Analytics.

```
heroku config:add GOOGLE_ANALYTICS_UA=UA-xxxxxx-x --app=doppler-staging
```

#### SSL Endpoint

```
$ heroku addons:add ssl:endpoint --app=doppler-staging

Adding ssl:endpoint on example... done, v1 ($20/mo)
```

#### SSL Certificate

```
$ heroku certs:add concatenated.crt artsy.net.key --app=doppler-staging

Resolving trust chain... done
Adding SSL Endpoint to doppler-staging... done
doppler-staging now served by kumamoto-4359.herokussl.com
Certificate details:
Common Name(s): *.artsy.net
                artsy.net
```

#### NewRelic

```
heroku addons:add newrelic:stark --app=doppler-staging
heroku config:add NEW_RELIC_APP_NAME=doppler --app=doppler-staging
heroku addons:add memcachier --app=doppler-staging
```

#### DNS

Add a CNAME record for the SSL endpoint. Production Doppler has developers.artsy.net pointing to kumamoto-4359.herokussl.com.

#### Push to Heroku

```
git push git@github.com:artsy/doppler.git master
```

