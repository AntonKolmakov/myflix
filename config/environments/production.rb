Myflix::Application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = true

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.cache_store = :redis_store, ENV['REDISTOGO_URL'], { expires_in: 90.minutes }

  config.active_support.deprecation = :notify

  config.action_mailer.default_url_options = { :host => 'shrouded-meadow-9922.herokuapp.com' }

  config.action_mailer.perform_deliveries = true

  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default :charset => "utf-8"
  
  ActionMailer::Base.smtp_settings = {
  :port           => ENV['MAILGUN_SMTP_PORT'],
  :address        => ENV['MAILGUN_SMTP_SERVER'],
  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  :domain         => 'yourapp.heroku.com',
  :authentication => :plain,
  }
  ActionMailer::Base.delivery_method = :smtp
end
