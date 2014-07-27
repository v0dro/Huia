module Huia
  module Bootstrap
    class Initialize < MethodClass

      def initialize binding
        super binding, 'initialize', proc { create_instance }
      end

    end
  end
end
