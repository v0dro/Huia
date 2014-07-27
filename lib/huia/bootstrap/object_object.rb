module Huia
  module Bootstrap

    # We have to bootstrap the minimum behaviour of `Object` with ruby, once
    # we have it set up we can switch to Huia to implement a lot of it's
    # functionality.
    # ObjectObject is a singleton, there can be only one.
    class ObjectObject
      MethodNotFound = Class.new(RuntimeError)

      attr_reader :ivar

      def initialize
        @ivar = IVarTable.new
        ivar.set 'methods', {}
      end

      def send_message name, *args
        get_method('responderForName:').send_message('callWithArgs:', *args)
      end

      def get_method name
        ivar.get('methods').fetch(name)
      rescue KeyError => e
        raise MethodNotFound, "Method `#{name}` not found in object `#{object_name}`"
      end

      def add_method
        method  = yield self
        methods = ivar.get 'methods'
        methods[method.signature] = method
      end

      def name
        'Object'
      end

      def object_name
        "<#{name}#0x#{object_id.to_i.to_s(16)}>"
      end
    end
  end
end
