require 'spec_helper'
require 'kickboxer/request'

describe Kickboxer::Request do
  it 'builds a url with api key' do
    Kickboxer.stub(:api_key).and_return('12345')

    req = described_class.new("ns/action")
    uri = URI.parse(req.build_url(username: 'jdoe'))

    uri.scheme.should eq 'https'
    uri.host.should eq 'api.fullcontact.com'
    uri.path.should eq '/v2/ns/action.json'
    q = uri.query || ""

    q.should =~ /username=jdoe/
    q.should =~ /apiKey=12345/
  end

  it 'raises an error if api key is not set' do
    Kickboxer.api_key.should be_nil
    lambda { described_class.run("ns/action", username: 'jdoe') }.should raise_error(Kickboxer::NoApiKeyError)
  end
end
