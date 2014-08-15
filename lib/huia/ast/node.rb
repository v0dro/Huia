module Huia
  module AST
    class Node
      attr_accessor :file, :line

      def bytecode g
        pos g
      end

      def pos g
        g.set_line line
      end

      def call_method method, *args
        puts "#{self.inspect} asked to call #{method} with args: #{args.inspect}"
      end

    end
  end
end
