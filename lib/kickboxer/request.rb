require 'kickboxer/config'
require 'kickboxer/response'

require 'open-uri'
require 'json'

module Kickboxer
  class Request
    BASE_URL = "https://api.fullcontact.com/v2"

    def initialize(action)
      @action = action
    end

    def build_url(options={})
      options[:apiKey] = Kickboxer.api_key
      raise NoApiKeyError unless options[:apiKey]

      querystring = options.map{|k,v| "#{ k }=#{ URI.escape v }" } * '&'
      "#{ BASE_URL }/#{ @action }.json?#{ querystring }"
    end

    def run(options={})
      debug = options.delete(:debug) || Kickboxer.debug

      response = open build_url(options)
      body = response.read

      if debug
        filename = debug.is_a?(String) ? debug : @action.gsub('/', '-')
        File.open("#{ filename }.json","w"){|out| out.puts body }
      end

      data = JSON.parse(body)

      code, text = response.status
      Response.new data.update(status_code: code.to_i, status_text: text)
    end

    def self.run(action, options={})
      new(action).run(options)
    end
  end
end
