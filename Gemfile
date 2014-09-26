source 'https://rubygems.org'

gem 'rails', '>= 4.0.0'
gem 'rake'

group :development do
  gem 'better_errors', '>= 0.3.2'
  gem 'binding_of_caller', '>= 0.6.8'
  gem 'sqlite3'
  gem 'capistrano', '~> 2.14.2'
  gem 'capistrano_rsync_with_remote_cache'
  gem 'hipchat'
  gem 'quiet_assets', '>= 1.0.1'
  gem 'rb-fsevent', :require => false
  gem 'pry'
  gem 'seed_dump'
  gem 'spring'
  gem 'rack-mini-profiler'
  gem 'guard-zeus'
  gem 'awesome_print', :require => false
end

# Gems used only for assets and not required
# in production environments by default.
  gem 'sass-rails',   '~> 4.0.0'
  # gem 'turbo-sprockets-rails3'
  # gem 'asset_sync'
  gem 'uglifier', '>= 1.3.0'

group :production do
  gem 'mysql2'
end

# authentication
gem 'devise'
gem 'devise-token_authenticatable'
gem 'cancancan'
gem 'rolify'

# storage
gem 'fog'
gem 'dalli' # Memcache store
gem 'aws-sdk'
gem 'paperclip'

# frontend
gem 'slim-rails'
gem 'will_paginate', '~> 3.0'
gem 'will_paginate-bootstrap'
gem 'taps'
gem 'nokogiri'
gem 'social-share-button'
gem 'meta-tags', :require => 'meta_tags'
gem 'figaro'
gem 'jquery-rails'
gem 'jquery-ui-rails', '>= 5.0.0'
# gem 'turbolinks'
# gem 'jquery-turbolinks' # Fixes JS for turbolinks
# gem 'nprogress-rails' # Progress bar for turbolinks
gem 'sitemap_generator'
gem 'friendly_id' # Better urls for deck
gem 'impressionist' # Track number of times profiles/decks are viewed
gem 'feedjira', :require => false # Parse rss feeds
gem 'lograge' # Minify log outputs
gem 'httparty' # Make them http requests easily
gem 'select2-rails'
gem 'unf'
gem 'acts_as_commentable_with_threading'
gem 'mailboxer' # User notifications and mailing
gem 'imgkit'
gem 'thin'
gem 'sanitize'
gem 'acts-as-taggable-on' # Tagging for decks
gem 'gon' # Easy Rails to JS Vars
gem 'ransack' # the new meta_search
gem 'shortener'
gem 'chartkick'
gem 'groupdate'
gem 'sync'

# DB
gem 'activerecord-import'

# APIs
gem 'newrelic_rpm'
gem 'cindy' # Sendy API
gem 'appsignal'
gem 'skylight'
gem 'pusher'

# Background
gem 'delayed_job_active_record'
gem 'delayed_job_web'
gem 'daemons'
gem 'whenever'

# Rails 4 upgrade
gem 'actionpack-action_caching', '~>1.0.0'
gem 'actionpack-page_caching', '~>1.0.0'
gem 'actionpack-xml_parser', '~>1.0.0'
gem 'actionview-encoded_mail_to', '~>1.0.4'
gem 'activerecord-session_store', '~>0.0.1'
gem 'activeresource', '~>4.0.0.beta1'
gem 'protected_attributes', '~>1.0.1'
gem 'rails-observers', '~>0.1.1'
gem 'rails-perftest', '~>0.0.2'

group :test do
  gem 'rspec-rails', '>= 2.13.2'
  gem 'email_spec', '>= 1.4.0'
  gem 'launchy', '>= 2.1.2'
  gem 'capybara', '>= 2.0.2'
  gem 'capybara-screenshot'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'guard-rspec'
  gem 'phashion'
end

group :development, :test do
  gem 'database_cleaner'
end
