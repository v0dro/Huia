module Huia
  module Bootstrap
    class DefaultResponder < MethodClass

      def initialize binding
        super binding, 'responderForName:', proc { |name| get_method(name) }
      end

    end
  end
end
