module Huia
  module AST
    class Assignment < Node

      attr_accessor :value, :index
      attr_reader :name

      def initialize name, value
        @name  = name
        @value = value
      end

      def bytecode g
        pos g

        value.bytecode g
        g.set_local index
      end
    end
  end
end
