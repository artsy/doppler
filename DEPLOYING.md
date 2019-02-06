Deploying Doppler
=================

Doppler is deployed to K8 with all the configuration checked in.

See [github.com/artsy/doppler/pull/154](https://github.com/artsy/doppler/pull/154) for details of switching from Heroku to K8.

#### Environment Settings

Add the following environment settings. The sample values below are for a staging deployment.

* ARTSY_API_URL=https://stagingapi.artsy.net
* ARTSY_API_CLIENT_ID=<Artsy API Client ID>
* ARTSY_API_CLIENT_SECRET=<Artsy API Client Secret>

You can use a key from a demo app created on [developers-staging.artsy.net](https://developers-staging.artsy.net). Note that staging is rebuilt nightly with production data, and your application will be deleted. If you need a persistent application, create it on [developers.artsy.net](http://developers.artsy.net) - it will be available on staging within 24 hours.
