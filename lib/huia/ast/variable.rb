module Huia
  module AST
    class Variable < Literal
      attr_reader :name

      def initialize name, value=nil
        @name = name
        super value
      end
    end
  end
end
