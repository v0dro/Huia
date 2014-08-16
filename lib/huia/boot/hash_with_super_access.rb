module Huia
  module Boot
    class HashWithSuperAccess

      def initialize superhash
        @superhash = superhash
        @localhash = {}
      end

      def [] key
        @localhash.fetch(key, @superhash[key])
      end

      def []= key, value
        @localhash[key] = value
      end

      def fetch *args
        if args.size == 1
          @localhash.fetch(args[0], @superhash.fetch(args[0], args[1]))
        else
          @localhash.fetch(args[0], @superhash.fetch(args[0], args[1]))
        end
      end

      def any?
        @localhash.any? || @superhash.any?
      end

      def method_missing method, *args
        @localhash.public_send(method, *args)
      end
    end
  end
end
