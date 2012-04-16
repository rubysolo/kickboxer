require 'spec_helper'
require 'kickboxer/response'

describe Kickboxer::Response do
  let(:response) {
    described_class.new('result' => {'age' => 37, 'location' => 'Denver'})
  }

  it 'builds methods dynamically in initialize block' do
    r = described_class.new do
      custom_method "hello"
      another_method 42
    end

    r.should respond_to(:custom_method)
    r.custom_method.should eq 'hello'

    r.should respond_to(:another_method)
    r.another_method.should eq 42

    r.should_not respond_to(:yet_another_method)
  end

  it 'accepts an initial data hash' do
    r = described_class.new('custom_method' => 'hello')
    r.should respond_to(:custom_method)
    r.custom_method.should eq 'hello'
    r.should_not respond_to(:another_method)
  end

  it 'merges initial data with block-defined data' do
    r = described_class.new('custom_method' => 'hello') do
      another_method 42
    end

    r.should respond_to(:custom_method)
    r.custom_method.should eq 'hello'

    r.should respond_to(:another_method)
    r.another_method.should eq 42

    r.should_not respond_to(:yet_another_method)
  end

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
