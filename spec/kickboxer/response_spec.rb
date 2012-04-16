require 'spec_helper'
require 'kickboxer/response'

describe Kickboxer::Response do
  let(:response) {
    described_class.new('result' => {'age' => 37, 'location' => 'Denver'})
  }

  it 'wraps nested hashes to allow chained method call access' do
    response.should respond_to(:result)
    response.result.should respond_to(:age)
    response.result.age.should eq 37
  end

  it 'makes hash keys accessible' do
    response.keys.should include :result
    response.result.keys.should include :age
  end
end
