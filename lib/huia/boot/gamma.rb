# This is the third-stage bootstrapping of object:
#
# Here we add a bunch of methods for working with Huia objects from Ruby.

module Huia
  module Boot
    module Gamma

      def huia_methods
        @methods
      end

      def huia_instance_methods
        @instanceMethods
      end

      def huia_private_methods
        @privateMethods
      end

      def huia_private_instance_methods
        @privateInstanceMethods
      end

      def huia_superclass
        @superclass
      end

      def huia_class
        @class
      end

      def huia_all_methods
        {}.tap do |h|
          %w| methods private_methods instance_methods private_instance_methods |.each do |method|
            methods = public_send("huia_#{method}")
            h[method.to_sym] = methods if methods && methods.any?
          end
        end
      end

      def huia_send message, *args
        __huia__send message, *args
      end

    end
  end
end
