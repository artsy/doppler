//= require swagger-ui

$ ->
  options = $('.swagger').data('swagger-options')
  window.swaggerUi = new SwaggerUi
    url: options.api_docs_url
    dom_id: "swagger-ui-container"
    supportHeaderParams: true
    supportedSubmitMethods: ['get', 'post', 'put', 'delete']
    onFailure: (data) ->
      $('#message-bar.swagger-ui-wrap')
        .addClass('alert')
        .addClass('alert-danger')
    onComplete: (swaggerApi, swaggerUi) ->
      swaggerUi.showMessage('loading API metadata ...')
      $('#swagger-ui-container .info').remove()
      $('#swagger-ui-container .footer').remove()
      setTimeout( =>
          $('#message-bar.swagger-ui-wrap').fadeOut(300, => @remove())
        3000)
    docExpansion: "list"

  window.swaggerUi.load()

  window.authorizations.add "key", new ApiKeyAuthorization("X-Access-Token", options.access_token, "header")
