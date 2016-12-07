source 'https://rubygems.org'

ruby '2.3.3'

# Custom Sources
# Custom source for GitHub because the default :github doesn't use HTTPS undler bundler 1.x.
git_source(:github_https){ |repo_name|  "https://github.com/#{repo_name}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# gem 'mysql'

# ls /usr/local/Cellar/postgresql/9.6.1/bin/pg_config
# env ARCHFLAGS="-arch x86_64" gem install pg -- --with-pg-config=/usr/local/Cellar/postgresql/9.3.3/bin/pg_config
# gem install pg -- --with-pg-config=/usr/local/Cellar/postgresql/9.3.3/bin/pg_config
gem 'pg'

# gem install mysql2 -- --with-mysql-config=/usr/local/Cellar/mysql/5.6.10/bin/mysql_config
# gem 'mysql2'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use ActiveResource for RESTful API calls.
# gem 'activeresource', github: 'rails/activeresource', branch: 'master'
# gem 'activeresource', git: 'https://github.com/rails/activeresource.git'
gem 'activeresource', github_https: 'rails/activeresource', branch: 'master'

# Use the money gem to handle currency values.
gem 'money-rails'


# Bootstrap
gem 'bootstrap', '~> 4.0.0.alpha5'
gem 'rails_layout'
gem 'font-awesome-rails'


# Pagination
gem 'kaminari'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails'

  # VCR framework for speeeding tests which call external APIs.
  gem 'vcr'
  gem 'net-http-spy'

  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
