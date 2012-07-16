$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
ENV["RAILS_ENV"] ||= "test"

begin
  require 'rails'
rescue LoadError
end

require 'bundler/setup'
Bundler.require

require 'database_cleaner'
require 'webmock/rspec'

# Simulate a gem providing a subclass of ActiveRecord::Base before the Railtie is loaded.
# require 'fake_gem' if defined? ActiveRecord

if defined? Rails
  require 'app/rails'

  require 'rspec/rails'
end
if defined? Sinatra
  require 'spec_helper_for_sinatra'
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
  config.mock_with :rr
end
