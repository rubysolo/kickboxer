require 'spec_helper'
require 'kickboxer/response'

describe Kickboxer::Response do
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
end
