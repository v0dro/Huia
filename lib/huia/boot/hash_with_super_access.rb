module Huia
  module Boot
    class HashWithSuperAccess
      attr_accessor :superhash

      def initialize superhash
        @superhash = superhash
        @localhash = {}
      end

      def [] key
        @localhash.fetch(key, @superhash[key])
      end

      def []= key, value
        raise ArgumentError, "can't write to frozen hash" if @prevent_modifications
        @localhash[key] = value
      end

      def fetch *args
        if args.size == 1
          @localhash.fetch(args[0], @superhash.fetch(args[0]))
        else
          @localhash.fetch(args[0], @superhash.fetch(args[0], args[1]))
        end
      end

      def keys
        (@superhash.keys + @localhash.keys).uniq.reject do |key|
          @localhash.has_key?(key) && @localhash.fetch(key) == nil
        end
      end

      def any?
        @localhash.any? || @superhash.any?
      end

      def freeze!
        @prevent_modification = true
      end

      def method_missing method, *args
        @localhash.public_send(method, *args)
      end

      def inspect
        "<Object#HashWithSuperAccess keys: [#{keys.map(&:inspect).join ", "}]>"
      end
    end
  end
end
