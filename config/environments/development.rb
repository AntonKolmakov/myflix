Myflix::Application.configure do
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { host: ENV['MAILER_HOST'] }
  
  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false
end
