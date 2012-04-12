require 'rubygems'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'rspec'
require 'rspec/autorun'

def stub_response(fixture, status=[200, "OK"])
  require 'kickboxer/request'
  response = StringIO.new IO.read("spec/fixtures/#{ fixture }.json")
  response.stub(:status).and_return(status)
  Kickboxer::Request.any_instance.stub(:open).and_return(response)
  Kickboxer.stub(:api_key).and_return('12345')
end

RSpec.configure do |config|
  config.mock_with :rspec
end
