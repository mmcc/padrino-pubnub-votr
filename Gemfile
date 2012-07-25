source :rubygems

# Server requirements
gem 'thin'
# gem 'trinidad', :platform => 'jruby'

# Project requirements
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'
gem 'pubnub'

# Component requirements
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'sass'
gem 'haml'
gem 'activerecord', :require => "active_record"

# Test requirements
gem 'shoulda', :group => "test"
gem 'rack-test', :require => "rack/test", :group => "test"

# Padrino Stable Gem
gem 'padrino', '0.10.7'

group :development do
	gem 'sqlite3'
end

group :production do
	gem 'pg'
end

# Or Padrino Edge
# gem 'padrino', :git => 'git://github.com/padrino/padrino-framework.git'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.10.7'
# end
