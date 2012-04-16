require 'spec_helper'
require 'kickboxer'

describe Kickboxer do
  it 'should load endpoint classes' do
    stub_response('name-normalize')
    response = Kickboxer::Name.normalize('Mr. John (Johnny) Michael Smith Jr.')

    response.status_code.should eq 200
    response.nameDetails.givenName.should eq 'John'
    response.nameDetails.familyName.should eq 'Smith'
  end
end
