module Kickboxer
  class Response
    def initialize(data={}, &block)
      @data = normalize data
    end

    def keys
      @data.keys
    end

    def respond_to?(method_id)
      @data.has_key?(method_id.to_sym) || @data.has_key?(method_id.to_s) || super
    end

    private

    def normalize(hash)
      hash.inject({}) do |h, (k,v)|
        h.update(normalize_key(k) => normalize_value(v))
      end
    end

    def normalize_key(key)
      key.to_sym
    end

    def normalize_value(value)
      value.is_a?(Hash) ? Response.new(normalize(value)) : value
    end

    def method_missing(key, *args)
      case
      when @data.has_key?(key.to_sym)
        @data[key.to_sym]
      when @data.has_key?(key.to_s)
        @data[key.to_s]
      else
        super
      end
    end
  end
end
