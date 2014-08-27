//= require swagger-ui

jQuery ->
  options = $('.swagger').data('swagger-options')
  window.swaggerUi = new SwaggerUi
    url: options.api_docs_url
    dom_id: "swagger-ui-container"
    supportHeaderParams: true
    supportedSubmitMethods: ['get', 'post', 'put', 'delete']
    onFailure: (data) ->
      console.log "Unable to Load SwaggerUI"
      console.log data
    onComplete: (swaggerApi, swaggerUi) ->
      $('pre code').each((i, e) ->
        hljs.highlightBlock(e)
      )
    docExpansion: "none"

  window.swaggerUi.load()

  window.authorizations.add "key", new ApiKeyAuthorization("X-Access-Token", options.access_token, "header")
