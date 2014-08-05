module Huia
  module AST
    class Lambda < Reducible

      attr_reader :arguments, :default_values, :scope

      def initialize scope
        @arguments      = []
        @default_values = []
        @scope          = scope
      end

      def arity
        @arguments.size
      end

      def append_arguments arguments
        arguments.each do |arg|
          if arg.respond_to?(:left) && arg.respond_to?(:right)
            append_argument arg.left, arg.right
          elsif arg.respond_to? :name
            append_argument arg
          end
        end
        self
      end

      def append_argument variable, default_value=nil
        @arguments      << variable
        @default_values << default_value
      end
    end
  end
end
