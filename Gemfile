source 'https://rubygems.org'

gem 'rails', '4.1.0'

# database
gem 'pg'

# configuration
gem 'squire', '~> 1.3.6'

# authentification
gem 'devise', '~> 3.1.1'
gem 'cancan', '~> 1.6.9'
gem 'net-ldap'

# stylesheets
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'font-awesome-rails', '~> 4.0.3'

# javascripts
gem 'therubyracer', platforms: :ruby
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap-datepicker-rails', '~> 1.3.0'
gem 'select2-rails', '~> 3.4.9'
gem 'jquery-tablesorter', '~> 1.9.5'
gem 'rails-timeago', '~> 2.0'
gem 'momentjs-rails'
gem 'jquery-textcomplete-rails', '~> 0.1.2'
gem 'handlebars_assets'
gem 'jquery-ui-rails'
gem 'd3_rails', '~> 3.4.6'
gem 'cal-heatmap-rails', '~> 0.0.1'

# markdown
gem 'redcarpet'
gem 'pygments.rb'
gem 'gemoji', '~> 1.5.0'

# internationalization
gem 'rails-i18n', '~> 4.0.0'
gem 'i18n-js', '~> 2.1.2'

# pagination
gem 'kaminari', '~> 0.15.1'
gem 'kaminari-bootstrap', '~> 3.0.1'

# scheduling
gem 'whenever'

# utilities
gem 'actionview-encoded_mail_to'
gem 'active_model_serializers'
gem 'activerecord-custom_timestamps'
gem 'forgery'
gem 'jbuilder', '~> 1.2'
gem 'murmurhash3'
gem 'nokogiri', '~> 1.6.1'
gem 'scout', github: 'smolnar/scout', branch: :master
gem 'statistics2'
gem 'symbolize'
gem 'timecop'

# monitoring
gem 'garelic'
gem 'newrelic_rpm'

# search
gem 'elasticsearch'

# documentation
group :doc do
  gem 'sdoc', require: false
end

# development
group :development do
  gem 'capistrano', '~> 2.15.5'
  gem 'capistrano-ext'
  gem 'rvm-capistrano'
end

# development & test
group :development, :test do
  # debugging
  gem 'pry'
  gem 'pry-debugger'
  gem 'hirb'

  # testing
  gem 'rspec-rails', '~> 2.0'
  gem 'fuubar'
  gem 'database_cleaner', '~> 1.2.0'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'capybara', '~> 2.2.1'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'poltergeist', '~> 1.5.0'
  gem 'guard-rspec'

  # database
  gem 'faker', '1.1.2'
end

group :production do
  gem 'unicorn'
  gem 'rack-timeout'
  gem 'exception_notification'
end
