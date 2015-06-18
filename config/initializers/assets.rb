Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile = ['*.js', '*.css', '*.png', '*.eot', '*.woff', '*.ttf']
Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/swagger-ui"