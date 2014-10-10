module Huia
  module Boot
    class HashWithSuperAccess
      attr_reader :superhash, :localhash

      def initialize superhash
        @superhash = superhash
        @localhash = {}
      end

      def [] key
        localhash.fetch(key) do
          superhash[key]
        end
      end

      def []= key, value
        raise ArgumentError, "can't write to frozen hash" if @prevent_modification
        localhash[key] = value
      end

      def fetch key, default=nil, &block
        localhash.fetch(key) do
          superhash.fetch(key, default, &block)
        end
      end

      def keys
        (superhash.keys + localhash.keys).uniq.reject do |key|
          localhash.has_key?(key) && localhash.fetch(key) == nil
        end
      end

      def has_key? key
        keys.include? key
      end

      def any? &block
        localhash.any?(&block) || superhash.any?(&block)
      end

      def freeze!
        @prevent_modification = true
      end

      def method_missing method, *args
        localhash.public_send(method, *args)
      end

      def inspect
        "<Object#HashWithSuperAccess keys: [#{keys.map(&:inspect).join ", "}]>"
      end
    end
  end
end
