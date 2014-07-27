module Huia
  module AST
    class Literal < Node

      attr_accessor :value

      def initialize value
        self.value = value
      end

    end
  end
end
