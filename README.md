## Doppler

[![CircleCI](https://circleci.com/gh/artsy/doppler.svg?style=svg)](https://circleci.com/gh/artsy/doppler)
[![Code Climate](https://codeclimate.com/github/artsy/doppler.svg)](https://codeclimate.com/github/artsy/doppler)

I am Doppler, the Artsy developer website. 

- **Production:** [developers.artsy.net](https://developers.artsy.net)
- **Staging:** [developers-staging.artsy.net/](https://developers-staging.artsy.net/)

### Setup

Clone the project:

```
$ git clone git@github.com:artsy/doppler.git
```

Review the setup script and run it _or the equivalent steps for your environment_:

```bash
$ cat bin/setup
$ bin/setup
```

Then it should be possibe to run tests:

```bash
bundle exec rspec
```

...or start the application (at http://localhost:3000):

```bash
foreman start
```

### Contributing

We welcome contributions. See [CONTRIBUTING](CONTRIBUTING.md) and [DEV](DEV.md).

### Copyright & License

MIT License, see [LICENSE](LICENSE) for details.

(c) 2014-2018 Artsy Inc. and Contributors
