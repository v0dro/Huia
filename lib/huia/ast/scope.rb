module Huia
  module AST
    class Scope < Node

      attr_reader :children, :parent, :arguments

      def initialize parent
        @children  = []
        @arguments = []
        @locals    = []
        @parent    = parent
      end

      def add_argument variable
        @arguments << variable
      end

      def arity
        @arguments.size
      end

      def allocate_local variable
        name = variable.name
        @locals.push name unless @locals.member? name
        variable.index = @locals.find_index name
      end

      def argument_names
        @arguments
      end

      def append node
        raise RuntimeError, "Cannot append a non-Node" unless node.is_a? Huia::AST::Node
        @children << node
        self
      end

      def bytecode g
        pos g

        blk = generate_block g
        compile_body blk

        g.create_block blk
      end

      private

      def compile_body g
        g.push_state self
        g.definition_line line
        pos g
        g.state.push_block
        g.push_modifiers
        g.break = nil
        g.next  = nil
        g.redo  = nil

        @children.each do |child|
          child.bytecode g
        end

        g.pop_modifiers
        g.state.pop_block
        g.ret
        g.close
        g.pop_state
      end

      def generate_block g
        blk               = g.class.new
        blk.file          = g.file
        blk.for_block     = true
        blk.required_args = arity
        blk.total_args    = arity

        blk
      end
    end
  end
end
