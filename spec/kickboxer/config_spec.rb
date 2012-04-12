require 'spec_helper'
require 'kickboxer/config'

describe Kickboxer do
  it 'stores an api key at the module level' do
    Kickboxer.api_key = '12345'
    Kickboxer.api_key.should eq '12345'

    # cleanup
    Kickboxer.api_key = nil
  end
end
