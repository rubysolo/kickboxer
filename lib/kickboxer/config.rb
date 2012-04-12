module Kickboxer
  def self.api_key=(value)
    @api_key = value
  end

  def self.api_key
    @api_key
  end

  def self.debug=(value)
    @debug = value
  end

  def self.debug
    @debug
  end

  class NoApiKeyError < RuntimeError; end
end
