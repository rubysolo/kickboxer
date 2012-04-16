module Kickboxer
  class Response
    def initialize(data={}, &block)
      @data = normalize data
      @data.merge!(Collector.new.instance_eval(&block).data) if block_given?
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

    class Collector
      attr_reader :data

      def method_missing(key, value)
        @data ||= {}
        @data[key] = value
        self
      end
    end
  end
end
