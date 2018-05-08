source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.6"
gem "mysql2", ">= 0.3.18", "< 0.6.0"
gem "i18n-js"
gem "bcrypt", "3.1.11"
gem "faker"
gem "will_paginate"
gem "bootstrap-will_paginate"
gem "carrierwave", "1.2.2"
gem "mini_magick", "4.7.0"
gem "jquery-rails"
gem "jquery-easing-rails"
gem "bootstrap-sass", "3.3.7"
gem "config"
gem "rails-controller-testing"
gem "font-awesome-rails"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "rubocop", require: false
gem "i18n-js"
# gem 'font-awesome-sass', '~> 5.0.9'
group :development, :test do
  gem "selenium-webdriver"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
