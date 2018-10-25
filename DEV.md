## Dev Stuff

### Upgrading Swagger-UI

Get the latest version of [swagger-ui](https://github.com/swagger-api/swagger-ui) from the [swagger-ui-dist distribution channel](https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/installation.md).

```
npm install swagger-ui-dist
```

Replace everything in [vendor/assets/swagger-ui-dist](vendor/assets/swagger-ui-dist) with the files from that distribution.

Make sure it works locally against staging, see [CONTRIBUTING](CONTRIBUTING.md) for how to setup Doppler locally.
