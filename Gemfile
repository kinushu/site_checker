source 'https://rubygems.org'

# Padrino supports Ruby version 1.9 and later
# ruby '2.2.3'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'sass'
gem 'erubis', '~> 2.7.0'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'sqlite3'

# Test requirements
gem 'rspec', :group => 'test'
gem 'rack-test', :require => 'rack/test', :group => 'test'

group :development do
  gem 'shotgun'

  gem "guard", "~> 2.0", require: false
  gem "guard-shotgun"
  gem "guard-compass"

  gem "rack-livereload"
  gem "guard-livereload", require: false
end

# Padrino Stable Gem
gem 'padrino', '0.13.0'

gem "nokogiri"
