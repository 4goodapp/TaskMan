ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '../app/', 'app.rb')
require 'rack/test'
require 'shoulda-matchers'

def app
  TaskMan
end

ActiveRecord::Base.logger = nil

app.set :logging, false
app.set :run, false
app.set :raise_errors, true

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

# Require factories
require File.dirname(__FILE__) + "/factories.rb"


