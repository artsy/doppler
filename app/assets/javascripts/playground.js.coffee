//= require swagger-ui-dist

$ ->

  options = $(".swagger").data("swagger-options")

  ui = SwaggerUIBundle({
    url: options.api_docs_url,
    dom_id: "#swagger-ui",
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout",
    configs: {
      preFetch: (req) ->
        req.headers["X-Access-Token"] = options.access_token
        return req
    }
  })

  window.ui = ui
