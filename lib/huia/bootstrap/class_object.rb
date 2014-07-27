module Huia
  module Bootstrap
    class ClassObject < ::Huia::Bootstrap.object_object

      def initialize
        super
        ivar.set 'instanceMethods', {}
        add_instance_method do |binding|
          Initialize.new binding
        end
      end

      def add_instance_method
        method = yield self
        methods = ivar.get 'instanceMethods'
        methods[method.signature] = method
      end

      def create_instance
      end

      def name
        'Class'
      end
    end
  end
end
